local map = require("helpers.keys").map

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
map("n", "<M-h>", "^", "Go to beginning of line")
map("n", "<M-l>", "$", "Go to end of line")

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
