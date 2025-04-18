local map = require("helpers.keys").map
local lsp_map = require("helpers.keys").lsp_map

-- Disable Arrow Keys On Normal And Visual Modes
map({ "n", "v" }, "<Up>", "<Nop>")
map({ "n", "v" }, "<Down>", "<Nop>")
map({ "n", "v" }, "<Left>", "<Nop>")
map({ "n", "v" }, "<Right>", "<Nop>")

-- Going Up And Down After Word Wrap
map("n", "j", "gj")
map("n", "k", "gk")

-- Blazingly Fast Way Out Of Insert Mode
map("i", "jk", "<esc>", "To go back to Normal Mode")

-- Quick Access To Some Common Actions
map("n", "<C-s>", "<cmd>w<cr>", "[S]ave a file")
map("n", "<leader>q", "<cmd>q<cr>", "[Q]uit")
map("n", "<leader>t", ":s/\\<./\\u&/g<CR>", "[T]itle-case")

-- Easier Access To Beginning And End Of Lines
map("n", "<S-H>", "^", "Go to beginning of line")
map("n", "<S-L>", "$", "Go to end of line")

-- Better Window Navigation
map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

-- Navigate Buffers
map("n", "<Tab>", "<cmd>bnext<cr>")
map("n", "<S-Tab>", "<cmd>bprevious<cr>")

-- Select The Whole File In A Buffer
map("n", "<C-a>", "ggVG", "Select Whole File in a Buffer")

-- Show Git Changes For Current Hunk
map("n", "G", ":Gitsigns preview_hunk<CR>", "Show Git Changes")

-- Lazy Dashboard
map("n", "<leader>l", "<cmd>Lazy<cr>")

-- Move When Highlighted
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- Copy For Whole System
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')

-- Move Half Page Down And Up
map("n", "<C-u>", "<C-u>zz", "Half Page [U]p")
map("n", "<C-d>", "<C-d>zz", "Half Page [D]own")

-- Mason
map("n", "<leader>m", "<cmd>Mason<cr>", "[M]ason")

-- LSP Keymaps
lsp_map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
lsp_map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Actions")
lsp_map("n", "<leader>rl", "<cmd>LspRestart<CR>", "Restart LSP")

-- Diagnostics
map("n", "D", vim.diagnostic.open_float, "Line Diagnostics")

-- Highlight On Yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Close Hover Window On ESC
vim.keymap.set("n", "<Esc>", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, true)
    end
  end
end, { silent = true, desc = "Close hover on ESC" })

---- TMUX Key Maps ----
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", "Tmux Window Left")
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", "Tmux Window Right")
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", "Tmux Window Down")
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", "Tmux Window Up")
