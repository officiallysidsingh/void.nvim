-- Pass In Any New LSP To Add
local lsp = {
  ensure_installed = {
    "lua_ls",
    "tsserver"
  }
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

lspconfig.lua_ls.setup{}

