-- Single source of truth for language support.
--
-- Add or remove a language by editing this one file; every integration
-- (mason-lspconfig, mason-conform, mason-nvim-dap, mason-tool-installer,
-- treesitter and the health check) reads from the tables below.
--
-- Every tool is tagged with the runtime Mason needs to install it:
--   "go"     -> needs `go`      on PATH
--   "npm"    -> needs `npm`     on PATH
--   "python" -> needs Python 3.10+
--   false    -> prebuilt binary, works on any machine
-- Tools whose runtime is missing are skipped automatically; a single warning
-- shows up at the end of startup (see helpers/toolchain.lua).

local M = {}

-- ---------------------------------------------------------------------------
-- LSP servers (lspconfig name -> runtime).
-- Installed by mason-lspconfig. Server-specific settings go in config/lsp.lua.
-- ---------------------------------------------------------------------------
M.servers = {
  -- Shell
  bashls = "npm",

  -- Docker
  dockerls = "npm",

  -- Golang
  gopls = "go",

  -- Protobuf
  buf_ls = false,

  -- Python
  pyright = "npm",

  -- Web Development (FrontEnd)
  ts_ls = "npm",
  html = "npm",
  tailwindcss = "npm",

  -- Config / data
  jsonls = "npm",
  yamlls = "npm",
  taplo = false, -- TOML
  marksman = false, -- Markdown

  -- SQL (installed, but not auto-enabled; see config/lsp.lua for why)
  sqlls = "npm",

  -- Lua
  lua_ls = false,
}

-- ---------------------------------------------------------------------------
-- Formatters (conform.nvim name -> runtime).
-- Installed by mason-conform. The filetype -> formatters map is below.
-- ---------------------------------------------------------------------------
M.formatters = {
  buf = false, -- Protobuf
  goimports = "go",
  golines = "go",
  gofumpt = "go",
  isort = "python",
  black = "python",
  prettierd = "npm",
  stylua = false,
  shfmt = false, -- Shell
  taplo = false, -- TOML (same tool as the LSP)
  sqlfluff = "python", -- SQL (also used by nvim-lint as a linter)
}

-- ---------------------------------------------------------------------------
-- Formatters per filetype, run in order by conform.nvim's format_on_save.
-- ---------------------------------------------------------------------------
M.formatters_by_ft = {
  proto = { "buf" },

  -- Go: fix imports, enforce line length, apply stricter formatting
  go = { "goimports", "golines", "gofumpt" },

  -- Python: sort imports first, then reformat
  python = { "isort", "black" },

  sh = { "shfmt" },
  bash = { "shfmt" },

  -- Web / data: prettierd is a long-running daemon, much faster than prettier
  javascript = { "prettierd" },
  typescript = { "prettierd" },
  javascriptreact = { "prettierd" },
  typescriptreact = { "prettierd" },
  css = { "prettierd" },
  html = { "prettierd" },
  json = { "prettierd" },
  yaml = { "prettierd" },
  markdown = { "prettierd" },
  graphql = { "prettierd" },

  toml = { "taplo" },

  -- sqlfluff only runs when the project has a .sqlfluff / pyproject.toml /
  -- setup.cfg / pep8.ini / tox.ini (conform enforces `require_cwd`).
  sql = { "sqlfluff" },

  lua = { "stylua" },
}

-- ---------------------------------------------------------------------------
-- Linters (Mason package name -> runtime).
-- Installed by mason-tool-installer. The filetype -> linters map is in
-- config/lint.lua.
-- ---------------------------------------------------------------------------
M.linters = {
  shellcheck = false,
  hadolint = false,
  -- sqlfluff lives in `formatters` above because it's a formatter too; the
  -- lint entry in config/lint.lua reuses the same binary.
}

-- ---------------------------------------------------------------------------
-- Debug adapters (Mason package name -> runtime).
-- Installed by mason-nvim-dap. Adapter-specific setup lives with the plugin
-- that integrates it (e.g. nvim-dap-go in config/nvim-dap.lua).
-- ---------------------------------------------------------------------------
M.debuggers = {
  delve = "go",
}

-- ---------------------------------------------------------------------------
-- Treesitter parsers to install on first launch.
-- Missing parsers are installed on demand the first time you open a file of
-- that type (see config/treesitter.lua), so this list is just a convenience
-- to warm the cache.
-- ---------------------------------------------------------------------------
M.parsers = {
  "bash",
  "css",
  "dockerfile",
  "go",
  "html",
  "javascript",
  "json",
  "markdown_inline",
  "proto",
  "python",
  "sql",
  "toml",
  "tsx",
  "typescript",
  "yaml",
}

return M
