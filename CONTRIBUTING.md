# Contributing

Notes for anyone (future me included) editing this config.

## Before you commit

1. `stylua .` — the repo is formatted with [StyLua](https://github.com/JohnnyMorganz/StyLua)
   using the settings in `.stylua.toml`. CI-style one-liner:
   `stylua --check .`
2. Open Neovim and let lazy.nvim settle (`:Lazy` should show no errors).
3. Run `:checkhealth config` and the relevant per-plugin health checks.
4. If you touched an LSP, formatter, linter or DAP, open a file of that
   language and confirm it attaches (`:checkhealth vim.lsp`, `:ConformInfo`).

## Commit style

Conventional commits — scope is the module touched. Keep each commit
focused on one thing; a change that reshapes the layout and adds a
feature should be two commits.

```
<type>(<scope>): <summary in the imperative, under 72 chars>

<optional body: why, not what — git shows what>
```

Types used here:

| Type | Use for |
| --- | --- |
| `feat` | New capability (plugin, language, keymap group) |
| `fix` | Bug fix or deprecation migration |
| `refactor` | Reshape without behaviour change |
| `chore` | Dependencies, tooling, config of config |
| `docs` | README, this file, `docs/`, in-file comments |

Scopes you'll see a lot: `bootstrap`, `lsp`, `treesitter`, `formatting`,
`lint`, `dap`, `testing`, `ui`, `keymaps`, `toolchain`, `languages`,
`health`.

## Adding a language

See [the README](README.md#adding-a-language) and
[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md). Every language-aware tool is
declared in `lua/config/languages.lua`; nothing else needs touching.

## Adding a plugin

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md#adding-a-plugin).

Rules of thumb:

- Prefer `event = { "BufReadPre", "BufNewFile" }`, `event = "VeryLazy"`,
  `cmd = …`, `ft = …` or `keys = …` over `lazy = false`.
- Keep plugin keymaps in the spec's `keys = { … }` table so lazy.nvim can
  lazy-load the plugin on first keypress.
- A plugin that needs more than two lines of configuration gets its own
  `lua/config/<name>.lua`.
- Prefer upstream `mason-org/*` over the archived `williamboman/*` repos.

## Updating plugins

```bash
nvim +Lazy
```

Inside `:Lazy`:

- `U` — update all plugins and refresh `lazy-lock.json`.
- `R` — restore every plugin to the pinned commit in `lazy-lock.json`.
- `?` — show every keybinding.

Then run `:TSUpdate` to update treesitter parsers and `:Mason` → `U` to
update language tools. Commit `lazy-lock.json` alongside any config change
the update required.

## Reporting a bug in this config

Include:

- `nvim --version`
- Output of `:checkhealth config`
- Output of `:Lazy log` (last few lines)
- The exact sequence of keystrokes or commands that triggers it
