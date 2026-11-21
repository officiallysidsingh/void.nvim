-- :checkhealth config
--
-- Reports every external program this config relies on, grouped by purpose,
-- with a one-line fix hint for each missing one. Run it whenever something
-- isn't working and you want to know whether it's a config bug or a missing
-- binary.

local M = {}

---Report one executable check with a WARN (plus actionable hint) if missing.
local function check_executable(cmd, purpose, hint)
  if vim.fn.executable(cmd) == 1 then
    vim.health.ok(("`%s` found"):format(cmd))
  else
    vim.health.warn(("`%s` not found: %s"):format(cmd, purpose), hint)
  end
end

function M.check()
  local toolchain = require("helpers.toolchain")
  local languages = require("config.languages")

  -- 1. Neovim itself
  vim.health.start("Neovim")
  if vim.fn.has("nvim-0.12") == 1 then
    vim.health.ok("Neovim " .. tostring(vim.version()))
  else
    vim.health.error("Neovim 0.12 or newer is required", "brew upgrade neovim")
  end

  -- 2. CLI tools used by various plugins
  vim.health.start("Core tools")
  check_executable("git", "needed by lazy.nvim and Mason", "brew install git")
  check_executable("rg", "needed by Telescope live grep", "brew install ripgrep")
  check_executable("fd", "optional, faster Telescope file finding", "brew install fd")
  check_executable("tree-sitter", "needed to install treesitter parsers", "brew install tree-sitter-cli")
  check_executable("cc", "needed to compile treesitter parsers", "xcode-select --install")

  -- 3. Language runtimes Mason needs to install tools. Lists every tool each
  --    runtime would install so you can see what breaks if one is missing.
  vim.health.start("Language runtimes (used by Mason to install tools)")
  local groups = { languages.servers, languages.formatters, languages.debuggers, languages.linters }
  for _, key in ipairs({ "go", "npm", "python" }) do
    local runtime = toolchain.runtimes[key]
    local tools = {}
    for _, group in ipairs(groups) do
      for tool, needs in pairs(group) do
        if needs == key then
          table.insert(tools, tool)
        end
      end
    end
    table.sort(tools)
    local list = table.concat(tools, ", ")
    if toolchain.has(key) then
      vim.health.ok(("%s found (%s)"):format(runtime.label, list))
    else
      vim.health.warn(("%s not found, not installing: %s"):format(runtime.label, list), runtime.hint)
    end
  end
end

return M
