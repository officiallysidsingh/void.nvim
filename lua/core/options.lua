local opts = {
  shiftwidth = 2,
  tabstop = 2,
  expandtab = true,
  wrap = true,
  termguicolors = true,
  number = true,
  relativenumber = true,

  -- From ThePrimeagen
  swapfile = false,
  backup = false,
  hlsearch = false,
  incsearch = true,
  scrolloff = 15,
}

-- Set options from table
for opt, val in pairs(opts) do
  vim.o[opt] = val
end

-- Set colorscheme
local colorscheme = require("helpers.colorscheme")
vim.cmd.colorscheme(colorscheme)
