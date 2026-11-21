-- Mason-tool-installer: installs standalone tools (linters and other prebuilt
-- binaries) that mason-lspconfig, mason-conform and mason-nvim-dap don't
-- cover. Today that's `shellcheck` and `hadolint`; sqlfluff is installed via
-- mason-conform because it also acts as a formatter.

local toolchain = require("helpers.toolchain")
local languages = require("config.languages")

local installable = toolchain.partition(languages.linters)

require("mason-tool-installer").setup({
  ensure_installed = installable,
  -- Don't auto-update tools on every start (noisy, and can break version
  -- compatibility with a project's `.sqlfluff` etc.); run `:MasonToolsUpdate`
  -- manually when you want new versions.
  auto_update = false,
  run_on_start = true,
  -- Only recheck once a day; pointless to hit the network every nvim start.
  debounce_hours = 24,
})

toolchain.notify_skipped()
