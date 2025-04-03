-- Mason Lsp-Config
local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
  error("Mason LSP-Config Error")
  return
end

-- Neovim Default LSP-Config
local status_ok_lspconfig, lspconfig = pcall(require, "lspconfig")
if not status_ok_lspconfig then
  error("LSPConfig Error")
  return
end

-- Pass In Any New LSP To Add
local lsp = {
  ensure_installed = {
    -- For Golang
    "gopls",

    -- For Web Development(FrontEnd)
    "ts_ls",
    "tailwindcss",

    -- For Lua
    "lua_ls",
  },
}

mason_lspconfig.setup(lsp)

-- Configuring lspconfig defaults
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities =
  vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

-------------------------------------- LSP Configurations ---------------------------------------------------
-- Golang
lspconfig.gopls.setup({
  settings = {
    gopls = {
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})

-- Web Development(FrontEnd)
lspconfig.ts_ls.setup({})
lspconfig.tailwindcss.setup({})

-- Lua
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "augroup", "Print" },
      },
    },
  },
})
