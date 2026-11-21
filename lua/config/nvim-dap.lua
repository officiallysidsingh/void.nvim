-- nvim-dap: debug adapter protocol client, UI and keymaps.
--
-- Adapter / language setup lives in each adapter plugin (nvim-dap-go, …);
-- this file wires keymaps, auto-opens dapui around a debug session, and
-- replaces the breakpoint / stopped line signs with Nerd Font icons.

local dap_map = require("helpers.keys").dap_map

local dap = require("dap")
local dap_ui = require("dapui")
local dap_go = require("dap-go")
local dap_virtual_text = require("nvim-dap-virtual-text")

dap_ui.setup()
dap_go.setup()
dap_virtual_text.setup()

-- ---------------------------------------------------------------------------
-- Keymaps
-- ---------------------------------------------------------------------------
-- Grouped under <leader>d. Which-key names the prefix in config/which-key.lua.

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
-- `?` because it mirrors Neovim's built-in `K` for hover: ask about this thing.
dap_map("n", "<leader>?", function()
  dap_ui.eval(nil, { enter = true })
end, "Evaluate Variable Under Cursor")

-- ---------------------------------------------------------------------------
-- Auto-open the DAP UI when a session starts; close it when it ends.
-- ---------------------------------------------------------------------------

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

-- ---------------------------------------------------------------------------
-- Signs
-- ---------------------------------------------------------------------------
-- A `DapStoppedLine` highlight that links to Visual so the current line
-- stays visible against our colorscheme.
vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

local dap_icons = {
  Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  Breakpoint = " ",
  BreakpointCondition = " ",
  BreakpointRejected = { " ", "DiagnosticError" },
  LogPoint = ".>",
}

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
