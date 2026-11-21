-- Mason: package manager for LSP servers, formatters, linters and debug
-- adapters. Everything it installs lives under stdpath("data")/mason/ and
-- is added to Neovim's PATH, isolated from the system.
--
-- The ensure_installed lists are owned by the per-concern plugins:
--   * mason-lspconfig        -> LSPs           (lua/config/lsp.lua)
--   * mason-conform          -> formatters     (lua/config/mason-conform.lua)
--   * mason-nvim-dap         -> debug adapters (lua/config/mason-nvim-dap.lua)
--   * mason-tool-installer   -> linters, etc.  (lua/config/mason-tool-installer.lua)
-- so this file only sets Mason's own UI icons.

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})
