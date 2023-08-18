local status_ok, tokyonight = pcall(require, "tokyonight")
if not status_ok then
 error("Tokyo-Night Error")
 return
end

tokyonight.setup({
  on_colors = function(colors)
    colors.bg = "#24283b"
  end,
  on_highlights = function(hl, c)
    hl.String = {
      fg = c.red,
    }
    hl.AlphaHeader = {
      fg = "#c90076",
    }
    hl.AlphaFooter = {
      fg = "#8aadf4",
    }
    hl.AlphaButtons = {
      fg = c.cyan,
    }
    hl.AlphaShortcut = {
      fg = c.purple,
    }
  end
})
