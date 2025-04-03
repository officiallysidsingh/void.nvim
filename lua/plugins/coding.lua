return {
  {
    "windwp/nvim-autopairs",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufNewFile" },
    ft = { "css", "html", "javascriptreact", "typescriptreact" },
    opts = {
      filetypes = { "css", "html", "javascriptreact", "typescriptreact" },
      user_default_options = {
        tailwind = true,
        sass = { enable = true, parsers = { "css" } },
      },
    },
  },
}
