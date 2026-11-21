-- Conform.nvim: filetype-based formatter runner.
--
-- The per-filetype table lives in config/languages.lua so every language's
-- LSP / formatter / parser / debugger are declared next to each other.
-- Per-tool arguments (dialect, indent, …) live here, since they're conform-
-- specific rather than "part of the language definition".

local languages = require("config.languages")

require("conform").setup({
  formatters_by_ft = languages.formatters_by_ft,

  -- Run on save for every buffer that has a formatter configured; otherwise
  -- fall back to the LSP's own formatProvider so even unconfigured languages
  -- (e.g. lua_ls) still format.
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 3000,
  },

  formatters = {
    -- sqlfluff requires an explicit SQL dialect; `ansi` is the safest
    -- lowest-common-denominator. Override per project by dropping a
    -- `.sqlfluff` file at the repo root (conform will pick it up, and
    -- sqlfluff itself respects the dialect specified there).
    sqlfluff = {
      prepend_args = { "--dialect", "ansi" },
    },

    -- shfmt: 2-space indent to match .editorconfig,
    --   -ci: indent switch cases,
    --   -s : simplify where possible (e.g. drop redundant subshells).
    shfmt = {
      prepend_args = { "-i", "2", "-ci", "-s" },
    },
  },
})
