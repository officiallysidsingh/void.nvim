-- Helper
local dap_map = require("helpers.keys").dap_map

-- NVIM DAP
local status_ok_dap, dap = pcall(require, "dap")
if not status_ok_dap then
  error("NVIM DAP Error")
  return
end

-- NVIM DAP UI
local status_ok_dap_ui, dap_ui = pcall(require, "dapui")
if not status_ok_dap_ui then
  error("NVIM DAP UI Error")
  return
end

-- NVIM DAP Go
local status_ok_dap_go, dap_go = pcall(require, "dap-go")
if not status_ok_dap_go then
  error("NVIM DAP Go Error")
  return
end

-- NVIM DAP UI
local status_ok_dap_virtual_text, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not status_ok_dap_virtual_text then
  error("NVIM DAP Virtual Text Error")
  return
end

-- Setup Dependencies
dap_ui.setup()
dap_go.setup()
dap_virtual_text.setup()

-- DAP Keymaps
dap_map("n", "<leader>db", function()
  dap.toggle_breakpoint()
end, "Toggle Breakpoint")
dap_map("n", "<leader>dc", function()
  dap.continue()
end, "Run/Continue")
dap_map("n", "<leader>dC", function()
  dap.run_to_cursor()
end, "Run To Cursor")
dap_map("n", "<leader>di", function()
  dap.step_into()
end, "Step Into")
dap_map("n", "<leader>do", function()
  dap.step_out()
end, "Step Out")
dap_map("n", "<leader>dO", function()
  dap.step_over()
end, "Step Over")
dap_map("n", "<leader>dB", function()
  dap.step_back()
end, "Step Back")
dap_map("n", "<leader>dt", function()
  dap.terminate()
end, "Terminate")
dap_map("n", "<leader>?", function()
  dap_ui.eval(nil, { enter = true })
end, "Evaluate Variable Under Cursor")

-- DAP UI
dap.listeners.before.attach.dapui_config = function()
  dap_ui.open()
end

dap.listeners.before.launch.dapui_config = function()
  dap_ui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
  dap_ui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
  dap_ui.close()
end

-- NVIM DAP Setup
vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

-- Define DAP icons
local dap_icons = {
  Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  Breakpoint = " ",
  BreakpointCondition = " ",
  BreakpointRejected = { " ", "DiagnosticError" },
  LogPoint = ".>",
}

-- Define DAP signs using the icons
vim.fn.sign_define("DapStopped", {
  text = dap_icons.Stopped[1],
  texthl = dap_icons.Stopped[2],
  linehl = dap_icons.Stopped[3],
  numhl = dap_icons.Stopped[3],
})

vim.fn.sign_define("DapBreakpoint", {
  text = dap_icons.Breakpoint,
  texthl = "DiagnosticSignWarn",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointCondition", {
  text = dap_icons.BreakpointCondition,
  texthl = "DiagnosticSignInfo",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = dap_icons.BreakpointRejected[1],
  texthl = dap_icons.BreakpointRejected[2],
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapLogPoint", {
  text = dap_icons.LogPoint,
  texthl = "DiagnosticSignHint",
  linehl = "",
  numhl = "",
})
