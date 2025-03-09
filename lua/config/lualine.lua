local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	error("Lualine Error")
	return
end

lualine.setup({
	options = {
		theme = "auto",
		globalstatus = true,
		disabled_filetypes = {
			statusline = { "dashboard", "alpha" },
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = {
			{
				"diagnostics",
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hint = " ",
				},
			},
			{
				"filetype",
				icon_only = true,
				separator = "",
				padding = { left = 1, right = 0 },
			},
			{
				function()
					-- If the buffer is unnamed, return an empty string.
					if vim.fn.expand("%:t") == "" then
						return ""
					else
						-- Return the full path (relative to home) if the file is named.
						return vim.fn.expand("%:p:~")
					end
				end,
				symbols = {
					modified = "  ",
					readonly = "",
					unnamed = "",
				},
			},
			{
				"lsp_progress",
				separators = {
					component = " ",
					progress = " | ",
					percentage = { pre = "", post = "%% " },
					title = { pre = "", post = ": " },
					lsp_client_name = { pre = "[", post = "]" },
					spinner = { pre = "", post = "" },
					message = { commenced = "In Progress", completed = "Completed" },
				},
				display_components = { "lsp_client_name", "spinner", { "title", "percentage", "message" } },
				timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
				spinner_symbols = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
			},
		},
		lualine_x = {
      -- stylua: ignore
      {
        "diff",
        symbols = {
          added = " ",
          modified = " ",
          removed = " ",
        },
      },
		},
		lualine_y = {
			{
				"progress",
				separator = " ",
				padding = { left = 1, right = 0 },
			},
			{
				"location",
				padding = { left = 0, right = 1 },
			},
		},
		lualine_z = {
			function()
				return " " .. os.date("%I:%M %p")
			end,
		},
	},
	extensions = {
		"neo-tree",
		"lazy",
	},
})
