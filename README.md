# Neovim Config

A personal Neovim configuration written in Lua and managed with
[lazy.nvim](https://github.com/folke/lazy.nvim).

It sets up LSP, completion, formatting on save, linting, debugging, testing,
treesitter highlighting, a file explorer, fuzzy finding, project-wide
search/replace, pretty notifications, in-buffer markdown rendering and
tmux-aware window navigation for Go, Python, TypeScript/JavaScript, HTML,
CSS, Tailwind CSS, Bash, Dockerfile, YAML, JSON, TOML, SQL, Markdown,
Protobuf and Lua.

## Requirements

| Tool | Why | Install (macOS) |
| --- | --- | --- |
| Neovim 0.12+ | native `vim.lsp.config`, treesitter `main` branch | `brew install neovim` |
| git | lazy.nvim and Mason | `brew install git` |
| A [Nerd Font](https://www.nerdfonts.com/) | icons | set it in your terminal |
| ripgrep | Telescope live grep | `brew install ripgrep` |
| tree-sitter CLI + C compiler | compiling treesitter parsers | `brew install tree-sitter-cli` |
| fd (optional) | faster Telescope file finding | `brew install fd` |

Mason builds most language tools from source, so each language also needs its
own runtime on your `PATH`:

| Runtime | Needed for | Install (macOS) |
| --- | --- | --- |
| Go | gopls, goimports, golines, gofumpt, delve | `brew install go` |
| Node.js (npm) | pyright, ts_ls, html, tailwindcss, prettierd | `brew install node` |
| Python 3.10+ | black, isort | `brew install python` |

A missing runtime is not an error. The tools that depend on it are skipped, you
get a single warning at startup, and everything else keeps working. Install the
runtime, restart Neovim, and the tools install themselves.

Run `:checkhealth config` at any time to see what is missing.

## Install

```bash
git clone <this-repo-url> ~/.config/nvim
```

```bash
nvim
```

On first launch lazy.nvim installs itself and every plugin, then Mason installs
the language servers, formatters and debug adapters. Plugin versions are pinned
in `lazy-lock.json`; run `:Lazy restore` to get exactly those versions.

## Layout

```
init.lua                  entry point
lua/core/                 options, keymaps, lazy.nvim bootstrap
lua/plugins/              plugin specs (what to install, when to load it)
lua/config/               plugin configuration (how it behaves)
lua/config/languages.lua  LSP servers, formatters, debuggers, parsers
lua/config/health.lua     :checkhealth config
lua/helpers/              small shared helpers
```

## Adding a language

Everything lives in [`lua/config/languages.lua`](lua/config/languages.lua).

1. **LSP server**: add it to `servers` using its
   [nvim-lspconfig name](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md),
   with the runtime Mason needs to install it (`"go"`, `"npm"`, `"python"`, or
   `false` for a prebuilt binary). It is installed and enabled automatically.
2. **Formatter**: add it to `formatters` using its
   [conform.nvim name](https://github.com/stevearc/conform.nvim#formatters),
   then list it under the filetype in `formatters_by_ft`.
3. **Treesitter parser**: add it to `parsers`. This is optional, since a
   missing parser is installed the first time you open a file of that type.
4. **Debug adapter**: add it to `debuggers` using its Mason name.

5. **Linter** (if one exists): add it to `linters` so mason-tool-installer
   picks it up, then list it per filetype in
   [`lua/config/lint.lua`](lua/config/lint.lua).

Server-specific settings go in [`lua/config/lsp.lua`](lua/config/lsp.lua):

```lua
vim.lsp.config("rust_analyzer", {
  settings = { ["rust-analyzer"] = { cargo = { allFeatures = true } } },
})
```

## Keymaps

The leader key is `Space`. Press it and wait to see every mapping in which-key.

### General

| Key | Action |
| --- | --- |
| `jj` (insert) | Back to normal mode |
| `Ctrl-s` | Save |
| `Space q` | Quit |
| `Shift-h` / `Shift-l` | Start / end of line |
| `Ctrl-h/j/k/l` | Move between splits and tmux panes |
| `Tab` / `Shift-Tab` | Next / previous buffer |
| `Ctrl-a` | Select the whole file |
| `Ctrl-j` / `Ctrl-k` (visual) | Move selection down / up |
| `Space y` | Yank to system clipboard |
| `Space t` | Title-case the current line |
| `Space u` | Undo tree |
| `Space l` | Lazy |
| `Space m` | Mason |

### Files and search

| Key | Action |
| --- | --- |
| `Space e` | File explorer |
| `Space Space` | Find files |
| `Space /` | Search text in the project |
| `/` | Fuzzy search in the current buffer |
| `Space ft` | Find TODO comments |
| `Space bs` | List buffers |
| `Space bp` | Pin buffer |
| `Space bdc` / `Space bdp` | Delete current buffer / all non-pinned |
| `Space gb` | Git branches |
| `G` | Preview git hunk |

### Code

| Key | Action |
| --- | --- |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `D` | Line diagnostics |
| `Space ca` | Code actions |
| `Space rl` | Restart LSP |
| `Ctrl-j` / `Ctrl-k` (completion) | Next / previous item |
| `Enter` (completion) | Confirm |
| `Tab` / `Shift-Tab` (snippet) | Next / previous placeholder |

Files are formatted on save.

### Debugging

| Key | Action |
| --- | --- |
| `Space db` | Toggle breakpoint |
| `Space dc` | Run / continue |
| `Space dC` | Run to cursor |
| `Space di` / `do` / `dO` | Step into / out / over |
| `Space dt` | Terminate |
| `Space ?` | Evaluate under cursor |

### Search / Replace (Spectre)

| Key | Action |
| --- | --- |
| `Space sr` | Project-wide search and replace |
| `Space sw` | Search current word (`v` mode: selection) |
| `Space sf` | Search in current file |

### Jump (Flash)

| Key | Action |
| --- | --- |
| `s` | Jump to any visible character sequence |
| `S` | Jump to any treesitter node |
| `r` (operator pending) | Remote flash |
| `R` (operator / visual) | Treesitter search |

### Diagnostics (Trouble)

| Key | Action |
| --- | --- |
| `Space xx` | Project diagnostics |
| `Space xX` | Buffer diagnostics |
| `Space xs` | Document symbols |
| `Space xl` | LSP references / definitions |
| `Space xL` / `xQ` | Location list / Quickfix list |

### Notifications (Noice)

| Key | Action |
| --- | --- |
| `Space nn` | Notification history |
| `Space nd` | Dismiss all notifications |

### Testing (neotest, Go only)

| Key | Action |
| --- | --- |
| `Space nr` | Run nearest test |
| `Space nf` | Run tests in the current file |
| `Space na` | Run every test in the project |
| `Space nl` | Run last test |
| `Space nd` | Debug the nearest test |
| `Space nx` | Stop the running test |
| `Space ns` | Toggle the summary |
| `Space no` | Show output for the last test |
| `Space nO` | Toggle the output panel |

Note that `G`, `D`, `/`, `Tab` and the arrow keys are remapped from their Vim
defaults (arrow keys are disabled in normal and visual mode).

## Maintenance

| Command | What it does |
| --- | --- |
| `:Lazy sync` | Update plugins and `lazy-lock.json` |
| `:Lazy restore` | Reset plugins to `lazy-lock.json` |
| `:Mason` | Manage language tools |
| `:TSUpdate` | Update treesitter parsers |
| `:checkhealth config` | Check external dependencies |
| `:ConformInfo` | Show formatters for the current buffer |

Lua is formatted with [StyLua](https://github.com/JohnnyMorganz/StyLua) using
`.stylua.toml`.

## Notes

- **SQL language server** (`sqlls`) is installed but not auto-enabled — it
  needs a per-project `.sqllsrc.json` or connection config. Enable it from
  `lua/config/lsp.lua` in projects where you want it.
- **sqlfluff** only runs when a `.sqlfluff`, `pyproject.toml`, `setup.cfg`,
  `pep8.ini` or `tox.ini` is present in the project root, so throw-away SQL
  files won't be auto-formatted on save.
