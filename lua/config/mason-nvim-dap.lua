-- Mason-NVIM-DAP: installs debug adapters declared in config/languages.lua.
--
-- `automatic_installation = false` so this plugin only installs the explicit
-- `ensure_installed` list; new filetypes won't surprise-install a debugger.
-- `handlers = {}` takes the default handler for every adapter, which is just
-- a passthrough into nvim-dap.

local toolchain = require("helpers.toolchain")
local languages = require("config.languages")

local installable = toolchain.partition(languages.debuggers)

require("mason-nvim-dap").setup({
  ensure_installed = installable,
  automatic_installation = false,
  handlers = {},
})

toolchain.notify_skipped()
