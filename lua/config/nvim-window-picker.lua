local status_ok, window_picker = pcall(require, "window-picker")
if not status_ok then
	error("Lualine Error")
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
