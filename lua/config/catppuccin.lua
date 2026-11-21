-- Catppuccin colorscheme (macchiato flavour) and alpha-dashboard highlights.
require("catppuccin").setup({
  flavour = "macchiato",
  custom_highlights = function(colors)
    return {
      AlphaHeader = { fg = colors.red },
      AlphaButtons = { fg = colors.teal },
      AlphaFooter = { fg = colors.lavender },
    }
  end,
})

vim.cmd.colorscheme("catppuccin")
