local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
  error("Catppuccin Error")
  return
end

catppuccin.setup({
  custom_highlights = function(colors)
    return {
      AlphaHeader = { fg = colors.red },
      AlphaButtons = { fg = colors.teal },
      AlphaFooter = { fg = colors.lavender },
    }
  end,
})
