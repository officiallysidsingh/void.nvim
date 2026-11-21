-- Toolchain detection for Mason integrations.
--
-- Mason builds most LSPs, formatters and debug adapters from source, so each
-- tool needs a language runtime (`go`, `npm`, Python 3.10+). On a fresh
-- machine, missing runtimes produce one "failed to install" error per tool on
-- every startup.
--
-- This module reports which runtimes are available and partitions a
-- `tool -> runtime` table into "installable" and "skipped". The Mason
-- integrations pass only the installable list to `ensure_installed`, and we
-- surface one short warning at the end of startup instead of a wall of
-- errors. Install the missing runtime and the tool installs on next launch.

local M = {}

-- Minimum Python version Mason requires for its pip-based installers
-- (black, isort, sqlfluff, ...). Older interpreters are considered absent.
local MIN_PYTHON = { 3, 10 }

-- Human-readable labels and fix hints shown in warnings and in
-- :checkhealth config. Keep hints macOS / Homebrew flavoured.
M.runtimes = {
  go = { label = "go", hint = "brew install go" },
  npm = { label = "npm", hint = "brew install node" },
  python = {
    label = ("python >= %d.%d"):format(MIN_PYTHON[1], MIN_PYTHON[2]),
    hint = "brew install python",
  },
}

-- Memoize detection across the session: `vim.fn.executable` fork-execs, which
-- adds up if we check every tool on every warning repaint.
local cache = {}

---Decide whether a Python new enough for Mason is available on PATH.
---Mason's pypi.lua first looks for versioned interpreters (python3.12, …) so
---we accept any of those; only if none exists do we fall back to the generic
---`python3` and parse its reported version.
local function has_python()
  for minor = MIN_PYTHON[2], 20 do
    if vim.fn.executable(("python%d.%d"):format(MIN_PYTHON[1], minor)) == 1 then
      return true
    end
  end
  if vim.fn.executable("python3") ~= 1 then
    return false
  end
  local out = vim.fn.system({ "python3", "-c", "import sys; print(sys.version_info[0], sys.version_info[1])" })
  local major, minor = out:match("(%d+)%s+(%d+)")
  major, minor = tonumber(major), tonumber(minor)
  if not major then
    return false
  end
  return major > MIN_PYTHON[1] or (major == MIN_PYTHON[1] and minor >= MIN_PYTHON[2])
end

---@param runtime string|nil Key of M.runtimes; nil / false means "no runtime"
---@return boolean           True if the runtime is on PATH (or none is needed)
function M.has(runtime)
  if runtime == nil then
    return true
  end
  if cache[runtime] == nil then
    if runtime == "python" then
      cache[runtime] = has_python()
    else
      cache[runtime] = vim.fn.executable(runtime) == 1
    end
  end
  return cache[runtime]
end

-- Tools that were skipped this session, keyed by the runtime that was missing:
--   { go = { "gopls", "goimports", ... }, npm = { ... } }
-- Used by notify_skipped() to produce one summary warning.
M.skipped = {}

---Split a `tool -> runtime` table into the tools whose runtime is present and
---the ones whose runtime is missing.
---
---@param tools table<string, string|false|nil> Tool name -> runtime key.
---  `false` / `nil` means "prebuilt binary, needs no runtime".
---@return string[] installable Tools whose runtime is on PATH (sorted)
---@return string[] skipped      Tools we had to skip (sorted; also recorded in M.skipped)
function M.partition(tools)
  local installable, skipped = {}, {}
  for tool, runtime in pairs(tools) do
    runtime = runtime or nil
    if M.has(runtime) then
      table.insert(installable, tool)
    else
      table.insert(skipped, tool)
      M.skipped[runtime] = M.skipped[runtime] or {}
      if not vim.list_contains(M.skipped[runtime], tool) then
        table.insert(M.skipped[runtime], tool)
      end
    end
  end
  table.sort(installable)
  table.sort(skipped)
  return installable, skipped
end

local notified = false

---Show one warning that lists every missing runtime, if any.
---Idempotent: safe to call from each Mason integration.
function M.notify_skipped()
  if notified then
    return
  end
  -- Partition every known tool group so the warning is complete no matter
  -- which plugin (mason-lspconfig / mason-conform / mason-nvim-dap /
  -- mason-tool-installer) happens to load and call us first.
  local languages = require("config.languages")
  M.partition(languages.servers)
  M.partition(languages.formatters)
  M.partition(languages.debuggers)
  M.partition(languages.linters)
  if next(M.skipped) == nil then
    return
  end
  notified = true

  local missing, count = {}, 0
  for runtime, tools in pairs(M.skipped) do
    table.insert(missing, M.runtimes[runtime].label)
    count = count + #tools
  end
  table.sort(missing)

  -- vim.schedule because we may be called from a fast-event context
  -- (plugin setup runs during BufReadPre, which doesn't allow API calls).
  vim.schedule(function()
    vim.notify(
      ("Mason: skipped %d tools, missing %s (:checkhealth config)"):format(count, table.concat(missing, ", ")),
      vim.log.levels.WARN
    )
  end)
end

return M
