local map = require("helpers.keys").map
local lsp_map = require("helpers.keys").lsp_map

-- Disable Arrow Keys On All Modes
map({ "n", "v" }, "<Up>", "<Nop>")
map({ "n", "v" }, "<Down>", "<Nop>")
map({ "n", "v" }, "<Left>", "<Nop>")
map({ "n", "v" }, "<Right>", "<Nop>")

-- Going Up and Down after Word Wrap
map("n", "j", "gj")
map("n", "k", "gk")

-- Blazingly fast way out of insert mode
map("i", "jk", "<esc>", "To go back to Normal Mode")

-- Quick access to some common actions
map("n", "<C-s>", "<cmd>w<cr>", "[S]ave a file")
map("n", "<leader>q", "<cmd>q<cr>", "[Q]uit")

-- Easier access to beginning and end of lines
map("n", "<S-H>", "^", "Go to beginning of line")
map("n", "<S-L>", "$", "Go to end of line")

-- Better window navigation
map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

-- Navigate buffers
map("n", "<Tab>", "<cmd>bnext<cr>")
map("n", "<S-Tab>", "<cmd>bprevious<cr>")

-- Lazy Dashboard
map("n", "<leader>l", "<cmd>Lazy<cr>")

-- LSP Keymaps
lsp_map("gd", vim.lsp.buf.definition, 0, "[G]o To [D]efinition")
lsp_map("gi", vim.lsp.buf.implementation, 0, "[G]o To [I]mplementation")
lsp_map("gt", vim.lsp.buf.type_definition, 0, "[G]o To [T]ype Definition")
lsp_map("K", vim.lsp.buf.hover, 0, "Hover Documantation")

-- Highlight On Yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

---- TMUX Key Maps ----
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", "Tmux Window Left")
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", "Tmux Window Right")
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", "Tmux Window Down")
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", "Tmux Window Up")

---- The Primeagen ----

-- Move When Highlighted
map("v", "<M-j>", "<cmd>m '>+1<cr>gv=gv")
map("v", "<M-k>", "<cmd>m '<-2<cr>gv=gv")

-- Copy For Whole System
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')

-- Move Half Page Down And Up
map("n", "<C-u>", "<C-u>zz", "Half Page [U]p")
map("n", "<C-d>", "<C-d>zz", "Half Page [D]own")
