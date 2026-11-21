# Architecture

A short tour of how this configuration is wired up, aimed at anyone who wants
to change or extend it.

## Loading order

```
init.lua
├── version guard (requires Neovim 0.12+)
├── core.options        set editor options first (buffer-independent)
├── core.lazy           bootstrap lazy.nvim and register plugins
│   ├── helpers.keys    set leader key before any plugin loads
│   └── plugins/*.lua   each returns a lazy.nvim spec table
└── core.keymaps        general keymaps (plugin keymaps live with their specs)
```

Plugin loading is governed by lazy.nvim. Most plugins declare `event`,
`cmd`, `ft` or `keys` triggers, so startup only loads what the first frame
needs. The exceptions (set `lazy = false`) are the colorscheme, the
dashboard, web-devicons, treesitter and vim-tmux-navigator.

## Module layout

```
init.lua                         Entry point and version guard
lua/core/
  ├── lazy.lua                   lazy.nvim bootstrap and global settings
  ├── options.lua                vim.o settings
  └── keymaps.lua                General-purpose keymaps
lua/helpers/
  ├── keys.lua                   Keymap helpers (map, lsp_map, dap_map, set_leader)
  └── toolchain.lua              Runtime detection (go, npm, python ≥ 3.10)
lua/config/
  ├── languages.lua              Single source of truth: LSPs / formatters /
  │                              linters / debuggers / parsers per language
  ├── lsp.lua                    vim.lsp.config overrides, enables mason-lspconfig
  ├── mason.lua                  Mason setup (just the UI tweaks)
  ├── mason-tool-installer.lua   Installs linters and other extras
  ├── mason-conform.lua          Installs formatters
  ├── mason-nvim-dap.lua         Installs debug adapters
  ├── conform.lua                Format-on-save with per-tool args
  ├── lint.lua                   nvim-lint, filetype -> linter map
  ├── neotest.lua                Test runner, adapters per language
  ├── treesitter.lua             Starts highlighting + on-demand parser install
  ├── health.lua                 :checkhealth config
  └── <plugin>.lua               per-plugin configuration (alpha, bufferline, …)
lua/plugins/                     Lazy.nvim specs grouped by topic
docs/                            This folder
```

### The `languages.lua` convention

Every language-aware tool is declared in [`lua/config/languages.lua`](../lua/config/languages.lua)
with the runtime Mason needs to install it:

| Value | Meaning |
| --- | --- |
| `"go"` | Needs `go` on PATH |
| `"npm"` | Needs `npm` on PATH |
| `"python"` | Needs Python 3.10 or newer |
| `false` | Prebuilt binary; works on any machine |

`helpers.toolchain.partition()` splits a table into _installable_ (runtime
available) and _skipped_ (runtime missing). Mason integrations receive only
the installable list, so a missing runtime produces a single warning instead
of one error per tool. Install the runtime, restart Neovim, and the tools
install on the next pass.

### LSP setup

The native `vim.lsp.config` API (Neovim 0.11+) replaces the old
`require("lspconfig")[server].setup` recipe. `nvim-lspconfig` is kept as a
_dependency_ only, so its `lsp/` directory provides the default server
definitions that we then override.

Flow:

1. `lua/config/lsp.lua` sets a `"*"` default (completion capabilities) and
   per-server overrides (`gopls`, `lua_ls`, `yamlls`, `jsonls`, …).
2. `mason-lspconfig.setup({ ensure_installed, automatic_enable })` installs
   each server from `languages.servers` and then enables the ones Mason
   actually installed via `vim.lsp.enable`.
3. `cmp_nvim_lsp.default_capabilities()` is attached so every server
   advertises completion to nvim-cmp.

### Treesitter

The rewritten `main` branch of `nvim-treesitter` ships only parsers and
queries; it does not enable highlighting itself. `lua/config/treesitter.lua`:

1. Installs the parsers listed in `languages.parsers` up front (needs the
   `tree-sitter` CLI on PATH).
2. On every `FileType` event, checks whether the language's parser is
   loaded; if not, installs it on demand, then calls `vim.treesitter.start()`.

### Format, lint, test

- **conform.nvim** runs formatters on save. The filetype → formatter map
  lives in `languages.formatters_by_ft`. Per-tool arguments
  (e.g. `sqlfluff --dialect ansi`) live in `lua/config/conform.lua`.
- **nvim-lint** runs linters on `BufWritePost` / `BufReadPost` /
  `InsertLeave`. The filetype → linter map lives in `lua/config/lint.lua`
  and gracefully skips linters whose binary is missing.
- **neotest** runs and debugs tests. Adapters go in `lua/config/neotest.lua`;
  the Go adapter debugs tests through `nvim-dap-go`.

## Adding a plugin

1. Create (or reuse) a `lua/plugins/<topic>.lua` file that returns a lazy.nvim
   spec. Prefer `event`, `cmd`, `ft` or `keys` triggers over `lazy = false`.
2. If the plugin needs more than two lines of config, put it in
   `lua/config/<plugin>.lua` and call it from the spec's `config = function()`.
3. If the plugin introduces new keymaps under a leader prefix, add the group
   name to `lua/config/which-key.lua`.
4. Run `stylua .` and open Neovim; lazy.nvim will install the plugin on first
   launch.

## Health checks

Run `:checkhealth config` (defined in `lua/config/health.lua`) to see
whether every runtime, CLI tool and treesitter dependency is present. Also
useful: `:checkhealth vim.lsp`, `:checkhealth vim.treesitter`,
`:Mason`, `:ConformInfo`, `:LazyLog`.
