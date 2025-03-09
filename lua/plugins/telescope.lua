return {
	-- Telescope Find Files
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = "Telescope",
		keys = {
			-- Grep
			{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Find Text In CWD" },
			{ "/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find Text In Current Buffer" },

			-- Files
			{ "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },

			-- Buffers
			{ "<leader>bs", "<cmd>Telescope buffers<cr>", desc = "[B]uffers [S]how" },

			-- Git Commands
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "[G]it [B]ranches" },

			-- LSP Definitions
			{ "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "[G]o To [D]efinition" },
		},
	},
}
