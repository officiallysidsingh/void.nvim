-- Mason-Conform: installs formatters that conform.nvim is configured to use.
--
-- mason-conform walks `conform.formatters_by_ft` and installs every formatter
-- it finds. We pass the list of formatters whose runtime is missing in
-- `ignore_install` so Mason doesn't try to build them and fail.

local toolchain = require("helpers.toolchain")
local languages = require("config.languages")

-- Only the skipped names are interesting here; the installable ones are
-- discovered automatically from conform's config.
local _, skipped = toolchain.partition(languages.formatters)

require("mason-conform").setup({
  ignore_install = skipped,
})

toolchain.notify_skipped()
