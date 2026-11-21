-- LSP: Mason + mason-lspconfig + nvim-lspconfig default definitions.
return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
    build = ":MasonUpdate",
    config = function()
      require("config.mason")
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      require("config.mason-tool-installer")
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInstall", "LspUninstall" },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig", -- default server definitions
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("config.lsp")
    end,
  },
}
