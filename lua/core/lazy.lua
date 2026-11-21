-- Bootstrap lazy.nvim and register every plugin in lua/plugins/.
--
-- lazy.nvim clones itself into stdpath("data")/lazy/lazy.nvim on first run,
-- then loads plugin specs from `lua/plugins/` (every file there returns a
-- table understood by lazy.nvim).

-- 1. Clone lazy.nvim on first launch if it's missing.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable", -- latest stable release of lazy.nvim itself
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    -- First-run clone failed (no network, GitHub down, …). Bail loudly rather
    -- than letting every later require() throw its own cryptic error.
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    return
  end
end
vim.opt.rtp:prepend(lazypath)

-- 2. Set the leader key BEFORE lazy loads any spec. lazy.nvim snapshots the
--    leader when it registers `<leader>…` maps, so a later change wouldn't
--    retroactively apply to those plugins.
require("helpers.keys").set_leader(" ")

-- 3. Register every plugin spec under lua/plugins/ and configure lazy itself.
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },

  defaults = {
    -- Every plugin is lazy by default; a spec opts in to eager loading with
    -- `lazy = false` (we do this only for the colorscheme, dashboard,
    -- devicons, treesitter and vim-tmux-navigator).
    lazy = true,
    -- Always run the latest commit of each plugin, not the most recent tag.
    -- Pinning happens in lazy-lock.json instead.
    version = false,
  },

  install = {
    -- First colorscheme to try when lazy.nvim installs plugins; `habamax`
    -- is a built-in fallback that always exists.
    colorscheme = { "catppuccin", "habamax" },
  },

  -- Check for plugin updates in the background. We don't prompt on startup
  -- (noisy); the pending-update count shows up in lualine instead.
  checker = {
    enabled = true,
    notify = false,
  },

  -- Reload modified plugin files automatically, but silently.
  change_detection = {
    notify = false,
  },

  performance = {
    rtp = {
      -- Disable Vim distribution plugins we don't use. Netrw is replaced by
      -- neo-tree, matchparen by treesitter's % behaviour, and the rest are
      -- archive handlers we never need in a Lua / Go / Python / TS workflow.
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrw",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
