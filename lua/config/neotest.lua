-- Neotest: run and debug tests from inside Neovim.
--
-- Neotest itself is framework-agnostic; language support comes from adapters.
-- Each adapter also needs the matching treesitter parser (so it can walk the
-- test tree) and, for debugging, a DAP adapter for that language.
--
-- Keymaps live in lua/plugins/testing.lua so lazy.nvim can lazy-load neotest
-- on first <leader>n keypress.

require("neotest").setup({
  adapters = {
    -- Golang: needs `go` on PATH and the "go" treesitter parser.
    -- Debugging works out of the box because dap_mode defaults to "dap-go",
    -- and our debugging spec already brings in leoluz/nvim-dap-go + delve.
    require("neotest-golang")({
      -- `-v`: show PASS/FAIL per test. `-count=1` disables Go's test cache
      -- so re-running actually re-runs (not "cached").
      go_test_args = { "-v", "-count=1" },
    }),
  },
})
