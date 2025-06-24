-- Conform.nvim
local status_ok, conform = pcall(require, "conform")
if not status_ok then
  error("Conform Error")
  return
end

-- Adding Formatting Sources
local formatters = {
  -- Protobuf
  proto = { "buf_ls" },

  -- Golang
  go = { "goimports", "golines", "gofumpt" },

  -- Python
  python = { "isort", "black" },

  -- Web Development(FrontEnd)
  javascript = { "prettierd" },
  typescript = { "prettierd" },
  javascriptreact = { "prettierd" },
  typescriptreact = { "prettierd" },
  css = { "prettierd" },
  html = { "prettierd" },
  json = { "prettierd" },
  yaml = { "prettierd" },
  markdown = { "prettierd" },
  grapql = { "prettierd" },

  -- Lua
  lua = { "stylua" },
}

conform.setup({
  formatters_by_ft = formatters,
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 3000,
  },
})
