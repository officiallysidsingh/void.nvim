-- Testing: neotest + per-language adapters, run and debug tests from the buffer.
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "fredrikaverpil/neotest-golang",
      "mfussenegger/nvim-dap", -- for debugging a test
    },
    -- stylua: ignore
    keys = {
      { "<leader>nr", function() require("neotest").run.run() end, desc = "[R]un Nearest Test" },
      { "<leader>nf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run [F]ile" },
      { "<leader>na", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run [A]ll Tests" },
      { "<leader>nl", function() require("neotest").run.run_last() end, desc = "Run [L]ast Test" },
      { "<leader>nd", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "[D]ebug Nearest Test" },
      { "<leader>nx", function() require("neotest").run.stop() end, desc = "Stop Test Run" },
      { "<leader>ns", function() require("neotest").summary.toggle() end, desc = "Toggle [S]ummary" },
      { "<leader>no", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show [O]utput" },
      { "<leader>nO", function() require("neotest").output_panel.toggle() end, desc = "Toggle [O]utput Panel" },
    },
    config = function()
      require("config.neotest")
    end,
  },
}
