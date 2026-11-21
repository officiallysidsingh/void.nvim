-- nvim-lint: runs linters on buffer events.
--
-- Linters are neither LSPs (they don't speak the protocol) nor formatters
-- (they don't rewrite the buffer). Their diagnostics land in the same
-- vim.diagnostic namespace as LSP diagnostics, so the same `D`, `:Trouble`
-- and sign column treat them identically.

local lint = require("lint")

-- Filetype -> linters to run. The matching Mason package is declared in
-- config/languages.lua's `linters` table so mason-tool-installer downloads it
-- (except sqlfluff which sits with the formatters since it does both jobs).
lint.linters_by_ft = {
  sh = { "shellcheck" },
  bash = { "shellcheck" },
  dockerfile = { "hadolint" },
  sql = { "sqlfluff" },
}

---Run just the linters whose executable is on PATH right now.
---Without this guard, nvim-lint raises a visible error on every save for any
---missing binary (e.g. on a machine where mason hasn't finished installing).
local function try_lint()
  local names = lint.linters_by_ft[vim.bo.filetype] or {}
  local available = {}
  for _, name in ipairs(names) do
    local linter = lint.linters[name]
    local cmd = type(linter) == "table" and (linter.cmd or linter.name) or name
    if type(cmd) == "function" then
      cmd = cmd()
    end
    if cmd and vim.fn.executable(cmd) == 1 then
      table.insert(available, name)
    end
  end
  if #available > 0 then
    lint.try_lint(available)
  end
end

-- Lint on save, on load, and when leaving insert mode (so errors appear as
-- you type pauses, not only on `:w`).
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
  callback = try_lint,
})
