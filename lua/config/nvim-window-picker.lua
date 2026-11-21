-- Window-picker: lets neo-tree ask which window to open a file in.
local status_ok, window_picker = pcall(require, "window-picker")
if not status_ok then
  error("Window Picker Error")
  return
end

window_picker.setup({
  filter_rules = {
    include_current_win = false,
    autoselect_one = true,
    bo = {
      filetype = { "neo-tree", "neo-tree-popup", "notify" },
      buftype = { "terminal", "quickfix" },
    },
  },
})
