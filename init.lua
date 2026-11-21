-- Entry point for Neovim. Everything is loaded from here in a fixed order.
--
-- This config targets Neovim 0.12+, which gives us:
--   - the native vim.lsp.config API (replaces require("lspconfig")[x].setup)
--   - the rewritten `main` branch of nvim-treesitter
--   - vim.uv over vim.loop
--
-- Load order matters:
--   1. version guard  -- bail out on older Neovim before anything else runs
--   2. core.options   -- set editor options before plugins can read them
--   3. core.lazy      -- bootstrap lazy.nvim, which sets the leader key, then
--                        loads plugin specs from lua/plugins/
--   4. core.keymaps   -- general keymaps (plugin-specific keymaps live with
--                        their plugin spec so lazy.nvim can lazy-load them)

if vim.fn.has("nvim-0.12") == 0 then
  vim.api.nvim_echo({ { "This config requires Neovim 0.12 or newer\n", "ErrorMsg" } }, true, {})
  return
end

require("core.options")
require("core.lazy")
require("core.keymaps")
