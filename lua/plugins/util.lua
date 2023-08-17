return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = {
        "buffers",
        "curdir",
        "tabpages",
        "winsize",
        "help",
        "globals",
        "skiprtp"
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    event = "BufReadPre",
    config = function()
      require ("config.harpoon")
    end,
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "[U]ndo Tree" },
    }
  },
  {
    "tpope/vim-fugitive",
    cmd = {"Git", "G"}
  }
}
