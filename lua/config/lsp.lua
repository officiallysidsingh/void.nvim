-- Pass In Any New LSP To Add
local lsp = {
  ensure_installed = {
    -- For Golang
    "gopls",

    -- For Web Development(FrontEnd)
    "tsserver",

    -- For Lua
    "lua_ls",
  },
}

-- Mason Lsp-Config
local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
  error("Mason LSP-Config Error")
  return
end

mason_lspconfig.setup(lsp)

-- Neovim Default LSP-Config
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  error("LSPConfig Error")
  return
end

-- LSP Configurations
-- Golang
lspconfig.gopls.setup({})

-- Web Development(FrontEnd)
lspconfig.tsserver.setup({})

-- Lua
lspconfig.lua_ls.setup({})

-- TODO: Add configurations for web dev and golang
