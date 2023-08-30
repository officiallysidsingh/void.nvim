local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  Print("Null-Ls Error")
  return
end
-- For Adding Formatters
local formatting = null_ls.builtins.formatting

-- Adding Formatting Sources
local sources = {
  -- Golang
  formatting.gofumpt,
  formatting.goimports,
  formatting.golines,

  -- Web Development(FrontEnd)
  formatting.prettierd,

  -- Lua
  formatting.stylua,
}

-- Pass Those To The Null-ls Setup
null_ls.setup({
  sources = sources,

  -- For Format On Save
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})
