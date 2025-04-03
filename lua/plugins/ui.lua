return {
  -- Tokyo Night ColorScheme
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("config.catppuccin")
    end,
  },

  -- Alpha Nvim
  {
    "goolord/alpha-nvim",
    lazy = false,
    config = function()
      require("config.alpha")
    end,
  },

  -- NVIM Web DevIcons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false, -- Ensure it's loaded on startup
    config = function()
      require("nvim-web-devicons").setup()
    end,
  },

  -- Buffer Line For Tabs
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "[P]in Toggle" },
      { "<leader>bdp", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Non-[P]inned" },
    },
    config = function()
      require("config.bufferline")
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
      require("config.which-key")
    end,
  },

  -- Lua Line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "arkav/lualine-lsp-progress",
    },
    config = function()
      require("config.lualine")
    end,
  },

  -- Indent Blank Line
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("config.indent-blankline")
    end,
    main = "ibl",
  },
}
