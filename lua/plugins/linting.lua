-- Linting: nvim-lint drives shellcheck / hadolint / sqlfluff on buffer events.
return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("config.lint")
    end,
  },
}
