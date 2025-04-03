-- Mason Conform
local status_ok, mason_conform = pcall(require, "mason-conform")
if not status_ok then
  error("Mason Conform Error")
  return
end

mason_conform.setup({
  ignore_install = {},
})
