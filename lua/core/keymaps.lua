-- General Neovim keymaps.
--
-- Plugin-specific keymaps live with their plugin spec in lua/plugins/<x>.lua
-- so lazy.nvim can lazy-load the plugin on first keypress. Keep this file
-- limited to keymaps that work without any plugin loaded (or with plugins
-- that are already loaded eagerly, like gitsigns and vim-tmux-navigator).

local map = require("helpers.keys").map
local lsp_map = require("helpers.keys").lsp_map

-- ----------------------------------------------------------------------------
-- Movement
-- ----------------------------------------------------------------------------

-- Disable arrow keys in normal and visual mode to build the habit of using
-- hjkl. Insert mode keeps them so editing still feels natural.
map({ "n", "v" }, "<Up>", "<Nop>")
map({ "n", "v" }, "<Down>", "<Nop>")
map({ "n", "v" }, "<Left>", "<Nop>")
map({ "n", "v" }, "<Right>", "<Nop>")

-- Move by display lines when text is soft-wrapped.
map("n", "j", "gj")
map("n", "k", "gk")

-- Quick escape from insert mode without reaching for Esc.
map("i", "jj", "<esc>", "To go back to Normal Mode")

-- Line-wise jumps that don't require reaching for `^` / `$`.
map("n", "<S-H>", "^", "Go to beginning of line")
map("n", "<S-L>", "$", "Go to end of line")

-- Window navigation that transparently crosses Neovim splits and tmux panes
-- (vim-tmux-navigator decides which one we're actually in).
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", "Navigate windows to the left")
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", "Navigate windows down")
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", "Navigate windows up")
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", "Navigate windows to the right")

-- Cycle buffers.
map("n", "<Tab>", "<cmd>bnext<cr>")
map("n", "<S-Tab>", "<cmd>bprevious<cr>")

-- Half-page scroll that re-centers the cursor afterwards.
map("n", "<C-u>", "<C-u>zz", "Half Page [U]p")
map("n", "<C-d>", "<C-d>zz", "Half Page [D]own")

-- ----------------------------------------------------------------------------
-- Editing
-- ----------------------------------------------------------------------------

-- File-level actions.
map("n", "<C-s>", "<cmd>w<cr>", "[S]ave a file")
map("n", "<leader>q", "<cmd>q<cr>", "[Q]uit")
map("n", "<C-a>", "ggVG", "Select Whole File in a Buffer")

-- Title-case every word on the current line (regex: upper-case the first
-- letter of each run of word characters).
map("n", "<leader>t", ":s/\\<./\\u&/g<CR>", "[T]itle-case")

-- Reflow the visual selection up or down, re-indenting after the move.
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- Yank straight into the system clipboard.
map({ "n", "v" }, "<leader>y", '"+y', "[Y]ank To System Clipboard")

-- ----------------------------------------------------------------------------
-- LSP and diagnostics
-- ----------------------------------------------------------------------------

lsp_map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
lsp_map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Actions")
-- `:lsp restart` is the built-in replacement for the deprecated :LspRestart
-- (nvim-lspconfig v3 dropped the user command).
lsp_map("n", "<leader>rl", "<cmd>lsp restart<CR>", "[R]estart [L]SP")

map("n", "D", vim.diagnostic.open_float, "Line Diagnostics")

-- ----------------------------------------------------------------------------
-- Git / tooling
-- ----------------------------------------------------------------------------

map("n", "G", ":Gitsigns preview_hunk<CR>", "Show Git Changes")
map("n", "<leader>l", "<cmd>Lazy<cr>", "[L]azy")
map("n", "<leader>m", "<cmd>Mason<cr>", "[M]ason")

-- ----------------------------------------------------------------------------
-- Autocmds
-- ----------------------------------------------------------------------------

-- Brief highlight on yanked text so you see exactly what went to the register.
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_group,
  pattern = "*",
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Close every floating window on Esc. This dismisses LSP hover docs, lazy.nvim
-- popups, noice messages, and anything else that opened as a floating window,
-- without touching regular splits (which aren't relative).
vim.keymap.set("n", "<Esc>", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, true)
    end
  end
end, { silent = true, desc = "Close hover on ESC" })
