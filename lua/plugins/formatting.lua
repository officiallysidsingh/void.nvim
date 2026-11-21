-- Formatting: conform.nvim + mason-conform to install the formatters.
return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = "ConformInfo",
    config = function()
      require("config.conform")
    end,
  },
  {
    "zapling/mason-conform.nvim",
    event = "VeryLazy",
    dependencies = {
      "mason-org/mason.nvim",
      "stevearc/conform.nvim",
    },
    config = function()
      require("config.mason-conform")
    end,
  },
}
