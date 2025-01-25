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

    diagnostics_indicator = function(_, _, diag)
      local result = {}

      if diag.error then
        table.insert(result, { text = " " .. diag.error, fg = "#FF0000" }) -- Red for errors
      end
      if diag.warning then
        table.insert(result, { text = " " .. diag.warning, fg = "#FFA500" }) -- Orange for warnings
      end

      return result
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
  }
})
