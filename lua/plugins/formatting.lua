return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("config.conform")
    end,
  },
  {
    "zapling/mason-conform.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "stevearc/conform.nvim",
    },
    config = function()
      require("config.mason-conform")
    end,
  },
}
