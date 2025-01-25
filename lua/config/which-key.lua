local status_ok, wk = pcall(require, "which-key")
if not status_ok then
	error("Which-Key Error")
	return
end

-- Setup `which-key` with configurations
wk.setup({
	plugins = {
		marks = true,
		registers = true,
		spelling = { enabled = true, suggestions = 20 },
	},
	icons = {
		breadcrumb = "»",
		separator = "",
		group = " ",
	},
	replace = {
		["<leader>"] = "SPC",
	},
})

-- Add key mappings with groups
wk.add({
	{ "<leader>b", group = "Buffer" },
	{ "<leader>bd", group = "Delete" },
	{ "<leader>bp", group = "Pinned" },
	{ "<leader>f", group = "Find (Telescope)" },
	{ "<leader>g", group = "Git" },
	{ "<leader>x", group = "Trouble Diagnostics" },
})
