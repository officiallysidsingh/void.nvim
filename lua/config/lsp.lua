-- LSP setup using the native vim.lsp.config API (Neovim 0.11+).
--
-- nvim-lspconfig is kept only as a dependency: its lsp/ directory supplies
-- the default command / filetypes / root-pattern for each server, and we
-- override on top of those with vim.lsp.config("<name>", { … }).
--
-- The install -> enable flow:
--   1. We declare which servers we want in config/languages.lua.
--   2. toolchain.partition() drops servers whose runtime (go/npm/python) is
--      missing, so Mason only tries to build what the machine can build.
--   3. mason-lspconfig installs the surviving list, then calls vim.lsp.enable
--      for every installed server. nvim-lspconfig's defaults + our overrides
--      above are what each enabled server runs with.

local toolchain = require("helpers.toolchain")
local languages = require("config.languages")

-- ---------------------------------------------------------------------------
-- Diagnostic UI
-- ---------------------------------------------------------------------------

-- Replace the default sign column symbols (E / W / I / H) with Nerd Font icons
-- that match the rest of the UI (lualine, bufferline).
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
    },
  },
})

-- ---------------------------------------------------------------------------
-- Defaults for every server
-- ---------------------------------------------------------------------------

-- Advertise nvim-cmp's extended completion capabilities to every server so
-- things like snippet support and resolveSupport work across the board.
vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- ---------------------------------------------------------------------------
-- Per-server overrides. Each call merges onto nvim-lspconfig's defaults.
-- A server without an entry here runs with the defaults as-is.
-- ---------------------------------------------------------------------------

vim.lsp.config("gopls", {
  settings = {
    gopls = {
      -- Placeholders in completion snippets for function parameters.
      usePlaceholders = true,
      analyses = {
        -- Flag unused function parameters (off by default in gopls).
        unusedparams = true,
      },
    },
  },
})

vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      -- Don't alphabetically reorder map keys when formatting, which would
      -- scramble ordered things like GitHub Actions `steps`.
      keyOrdering = false,
      format = { enable = true },
      validate = true,
    },
  },
})

vim.lsp.config("jsonls", {
  settings = {
    json = {
      validate = { enable = true },
    },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" }, -- Neovim embeds LuaJIT
      diagnostics = {
        -- `vim` is injected globally into every Neovim config file; without
        -- this, lua_ls flags it as undefined everywhere.
        globals = { "vim" },
      },
      workspace = {
        -- Expose Neovim's own runtime files so LSP knows about vim.api,
        -- vim.fn, etc. without the "Do you want to load your workspace as a
        -- Lua library?" popup.
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
})

-- ---------------------------------------------------------------------------
-- Install + enable
-- ---------------------------------------------------------------------------

-- Drop servers whose runtime is missing; a single warning for the skipped
-- ones shows up at the end of startup (see helpers/toolchain.lua).
local installable = toolchain.partition(languages.servers)

require("mason-lspconfig").setup({
  ensure_installed = installable,
  -- Automatically run vim.lsp.enable() for every installed server, except:
  --   * stylua  — mason-lspconfig sees stylua as an "LSP" since it ships a
  --               language-server mode, but we format via conform.nvim.
  --   * sqlls   — needs a per-project .sqllsrc.json or a DB connection; it
  --               crashes without one. Enable it manually in projects that
  --               actually configure it.
  automatic_enable = { exclude = { "stylua", "sqlls" } },
})

toolchain.notify_skipped()
