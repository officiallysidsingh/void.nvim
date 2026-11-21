-- Keymap helpers: thin wrappers around vim.keymap.set that apply our defaults.
--
-- All of them default to `silent = true` so messages don't flash in the
-- cmdline every time you press a key; LSP maps additionally set `noremap`
-- so a redefined `K` or `<leader>ca` never recurses through a user mapping.

local M = {}

---@param mode string|string[] "n", "v", "i", "x", "o", … or a list of modes
---@param lhs string           Left-hand side (the key sequence)
---@param rhs string|function  Right-hand side (a command or a Lua callback)
---@param desc string|nil      Shows up in which-key and :map listings
function M.map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

---Keymap for LSP actions: silent + noremap so the mapping never recurses.
function M.lsp_map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

---Keymap for DAP actions. Kept as its own helper for future symmetry (e.g.
---guarding on `require("dap").session() ~= nil`).
function M.dap_map(mode, lhs, rhs, desc)
  M.map(mode, lhs, rhs, desc)
end

---Set the global and local-buffer leader keys and make the raw key a no-op.
---This must run BEFORE any plugin registers a `<leader>` mapping, because
---lazy.nvim resolves leader at mapping registration time, not at key press.
function M.set_leader(key)
  vim.g.mapleader = key
  vim.g.maplocalleader = key
  M.map({ "n", "v" }, key, "<nop>")
end

return M
