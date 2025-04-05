-- Mason
local status_ok_mason, mason = pcall(require, "mason")
if not status_ok_mason then
  error("Mason Error")
  return
end

-- Mason Lsp-Config
local status_ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_mason_lspconfig then
  error("Mason LSP-Config Error")
  return
end

-- Pass In Any New LSP To Add
local lsp = {
  ensure_installed = {
    -- Golang
    "gopls",

    -- Python
    "pyright",

    -- Web Development(FrontEnd)
    "ts_ls",
    "html",
    "cssls",
    "tailwindcss",

    -- Lua
    "lua_ls",
  },
  automatic_installation = true,
}

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

mason_lspconfig.setup(lsp)
