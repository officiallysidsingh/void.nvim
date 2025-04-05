return {
  -- Completion UI Plugins

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-path", -- source for file system paths
      "hrsh7th/cmp-cmdline", -- source for commands
      "L3MON4D3/LuaSnip", -- snippet engine
      "saadparwaiz1/cmp_luasnip", -- for autocompletion
      "rafamadriz/friendly-snippets", -- source for useful snippets
      "hrsh7th/cmp-nvim-lsp", -- source for lsp
    },
    config = function()
      require("config.completion")
    end,
  },
}
