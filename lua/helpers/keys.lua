local M = {}

M.map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

M.lsp_map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

M.dap_map = function(mode, lhs, rhs, desc)
  M.map(mode, lhs, rhs, desc)
end

M.set_leader = function(key)
  vim.g.mapleader = key
  vim.g.maplocalleader = key
  M.map({ "n", "v" }, key, "<nop>")
end

return M
