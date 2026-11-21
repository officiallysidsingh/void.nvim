-- Search: nvim-spectre for project-wide search and replace.
return {
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").toggle() end, desc = "Search/Replace in Project" },
      { "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Search Current Word" },
      { "<leader>sw", mode = "v", function() require("spectre").open_visual() end, desc = "Search Selection" },
      { "<leader>sf", function() require("spectre").open_file_search({ select_word = true }) end, desc = "Search Current File" },
    },
    opts = {},
  },
}
