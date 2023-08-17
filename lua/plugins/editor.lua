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
      {
        "<leader>e",
        "<cmd>Neotree toggle<cr>",
        desc = "[E]xplorer"
      }
    },
    config = function()
      require ("config.neo-tree")
    end,
  },

  --Mini Bufremove
  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
     { "<leader>bdc", function() require("mini.bufremove").delete(0, false) end, desc = "[B]uffer [D]elete [C]urrent" },
    },
  },

  -- Todo Comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    -- stylua: ignore
    keys = {
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "[T]odo (Telescope)" },
    },
  },

  -- Trouble
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "[D]ocument Diagnostics" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "[W]orkspace Diagnostics" },
    },
  },

  -- Telescope Find Files
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    cmd = "Telescope",
    keys = {
      -- Grep
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Find Text In CWD" },
      { "/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find Text In Current Buffer"},

      -- Files
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "[F]ind [G]it files"},

      -- Git Commands
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "[G]it [B]ranches"},
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "[G]it [S]tatus"},

      -- Help
      { "<C-h>", "<cmd>Telescope help_tags<cr>", desc = "[H]elp" },

      -- Treesitter Functions
      { "<C-f>", "<cmd>Telescope treesitter<cr>", desc = "List All Functions" }
    },
  },
  
  -- Git Signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require ("config.gitsigns")
    end,
  },
}
