 return {
  -- Neo Tree
  {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "[E]xplorer" }
    },
		config = function()
      require ("config.neo-tree")
		end,
	},
}
