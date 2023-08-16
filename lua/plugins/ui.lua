return {
  -- Tokyo Night ColorScheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  -- Alpha Nvim
  {
    "goolord/alpha-nvim",
    lazy = false,
    config = function ()
      require ("config.alpha")
    end,
  },

  -- Buffer Line For Tabs
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
		version = "v3.x",
		dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<leader>p", "<Cmd>BufferLineTogglePin<CR>", desc = "[P]in buffer" },
      { "<leader>dp", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "[D]elete non-[P]inned buffers" },
    },
		config = function()
      require ("config.bufferline")
    end,
  },
  
  -- Which Key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require ("config.which-key")
		end,
  },

  -- Lua Line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require ("config.lualine")
    end,
  },

  -- Indent Blank Line
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("config.indent-blankline")
    end,
  },
}
