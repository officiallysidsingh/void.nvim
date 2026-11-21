-- Editor options (vim.o). Loaded before any plugin so plugin setup code
-- that reads these values (e.g. tab size, true colors) sees the right thing.

local opts = {
  -- Indentation: 2 spaces everywhere; language-specific overrides live in
  -- ftplugin/<ft>.lua or come from the LSP / formatter configuration.
  shiftwidth = 2,
  tabstop = 2,
  expandtab = true,

  -- Soft-wrap long lines rather than hiding the overflow.
  wrap = true,

  -- 24-bit color; required by catppuccin and most modern plugins.
  termguicolors = true,

  -- Line numbers: absolute on the current line, relative elsewhere, so jumps
  -- like `5j` and `10k` are easy to count.
  number = true,
  relativenumber = true,

  -- From ThePrimeagen: no swap / backup files (we have undo history +
  -- persistence.nvim); search is incremental but not highlighted after Enter.
  swapfile = false,
  backup = false,
  hlsearch = false,
  incsearch = true,

  -- Keep the cursor away from the top / bottom edges while scrolling.
  scrolloff = 15,
}

for opt, val in pairs(opts) do
  vim.o[opt] = val
end
