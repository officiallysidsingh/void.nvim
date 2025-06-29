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

-- Protobuf
lspconfig["buf_ls"].setup({
  capabilities = capabilities,
  filetypes = { "proto" },
})

-- Golang
lspconfig["gopls"].setup({
  capabilities = capabilities,
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
  filetypes = { "python" },
})

-- Web Development(FrontEnd)
lspconfig["ts_ls"].setup({
  capabilities = capabilities,
})

lspconfig["html"].setup({
  capabilities = capabilities,
})

lspconfig["tailwindcss"].setup({
  capabilities = capabilities,
})

-- Lua
lspconfig["lua_ls"].setup({
  capabilities = capabilities,
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
