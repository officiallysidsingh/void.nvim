-- Mason NVIM DAP
local status_ok_mason_nvim_dap, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not status_ok_mason_nvim_dap then
  error("Mason NVIM DAP Error")
  return
end

-- Pass In Any New DAP To Add
local dap = {
  ensure_installed = {
    -- Golang
    "delve",
  },
  handlers = {},
  automatic_installation = true,
}

mason_nvim_dap.setup(dap)
