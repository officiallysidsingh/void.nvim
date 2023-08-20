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
			{ "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "[F]ind [G]it files" },

			-- Git Commands
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "[G]it [B]ranches" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "[G]it [S]tatus" },

			-- Treesitter Functions
			{ "<C-f>", "<cmd>Telescope treesitter<cr>", desc = "List All Functions" },

			-- LSP References
			{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "[G]o To [R]eferences" },
		},
	},
}
