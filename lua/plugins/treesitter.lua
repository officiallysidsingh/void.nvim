-- Treesitter: parser installation; highlighting is started per buffer in config.treesitter.
return {
  {
    -- The `main` branch is a rewrite for Neovim 0.12+ and does not support lazy-loading
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  },
}
