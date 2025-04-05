-- Nvim LSP-Config
local status_ok_lspconfig, lspconfig = pcall(require, "lspconfig")
if not status_ok_lspconfig then
  error("Nvim LSPConfig Error")
  return
end

local status_ok_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok_cmp_nvim_lsp then
  error("CMP Nvim LSP Error")
  return
end

local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change The Diagnostic Symbols In The Gutter
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
    },
  },
})

-- Golang
lspconfig["gopls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})

-- Python
lspconfig["pyright"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Web Development(FrontEnd)
lspconfig["ts_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["html"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["tailwindcss"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Lua
lspconfig["lua_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      -- Make LSP recognize "vim" Global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- Make LSP aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})
