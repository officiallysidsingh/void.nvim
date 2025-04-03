local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  vim.notify("BufferLine Error", vim.log.levels.ERROR)
  return
end

bufferline.setup({
  options = {
    separator_style = "slant",
    always_show_bufferline = false,
    indicator = {
      style = "underline",
    },
    diagnostics = "nvim_lsp",

    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,

    offsets = {
      {
        filetype = "neo-tree",
        text = "Neo-tree",
        highlight = "Directory",
        text_align = "center",
        separator = true,
      },
    },
    show_buffer_icons = false,
    modified_icon = "●",
    show_close_icon = false,
    show_buffer_close_icons = false,
  },
})
