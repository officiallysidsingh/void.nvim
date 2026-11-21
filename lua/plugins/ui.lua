-- UI layer: colorscheme, dashboard, bufferline, statusline, which-key, notifications.
return {
  -- Catppuccin ColorScheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
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

  -- Pretty notifications (also powers noice's history)
  {
    "rcarriga/nvim-notify",
    lazy = true,
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      render = "wrapped-compact",
      stages = "static",
    },
  },

  -- Replaces cmdline / messages / popupmenu with a nicer UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
      routes = {
        -- Push "written" and similar noise to the mini view
        { filter = { event = "msg_show", kind = "", find = "written" }, view = "mini" },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>nn", function() require("noice").cmd("history") end, desc = "[N]otifications History" },
      { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "[D]ismiss Notifications" },
    },
  },

  -- In-buffer markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      file_types = { "markdown" },
      code = {
        sign = false,
        width = "block",
        min_width = 45,
      },
      heading = {
        sign = false,
      },
    },
  },
}
