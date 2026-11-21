-- nvim-cmp completion engine + LuaSnip snippets.
--
-- Sources (in priority order): LSP, LuaSnip, current buffer, filesystem paths.
-- Keymaps favor Ctrl-based navigation so `Tab` is left to snippets and so
-- completion doesn't fight with vim motion muscle memory.

local map = require("helpers.keys").map
local cmp = require("cmp")
local luasnip = require("luasnip")
local luasnip_loaders = require("luasnip.loaders.from_vscode")

-- ---------------------------------------------------------------------------
-- LuaSnip
-- ---------------------------------------------------------------------------

-- Load snippets bundled with friendly-snippets (VSCode format) on demand.
luasnip_loaders.lazy_load()

-- Tab = jump to the next snippet placeholder when inside one, otherwise the
-- real Tab key. Shift-Tab goes to the previous placeholder in insert/select.
map("i", "<Tab>", function()
  return luasnip.jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
end)
map("s", "<Tab>", function()
  luasnip.jump(1)
end)
map({ "i", "s" }, "<S-Tab>", function()
  luasnip.jump(-1)
end)

-- ---------------------------------------------------------------------------
-- nvim-cmp
-- ---------------------------------------------------------------------------

cmp.setup({
  completion = {
    -- `fuzzy` for substring matching, `noinsert` so arrow keys don't overwrite
    -- the buffer text as you preview completions, `preview` for the inline
    -- ghost text.
    completeopt = "fuzzy,menu,menuone,noinsert,preview",
  },

  -- Tell nvim-cmp how to expand a snippet when a completion item carries one.
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    -- Navigate the completion menu with Ctrl-j/k so it mirrors our other
    -- "move within a thing" keybinds (telescope, dap-ui, etc.).
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),

    ["<C-e>"] = cmp.mapping.abort(),

    -- `select = false` means Enter only accepts an item if you've explicitly
    -- highlighted one, so pressing Enter after a word still inserts a newline.
    ["<CR>"] = cmp.mapping.confirm({ select = false }),

    -- Scroll the documentation popup.
    ["<C-d>"] = cmp.mapping(function()
      cmp.scroll_docs(4)
    end, { "i" }),
    ["<C-u>"] = cmp.mapping(function()
      cmp.scroll_docs(-4)
    end, { "i" }),

    -- Toggle the documentation popup when it's not already open.
    ["<C-x>"] = cmp.mapping(function()
      if cmp.visible_docs() then
        cmp.close_docs()
      else
        cmp.open_docs()
      end
    end, { "i" }),
  }),

  -- Sources, in match priority order. LSP is capped at 5 items because some
  -- servers (ts_ls, pyright) return hundreds of matches and bury the good ones.
  sources = cmp.config.sources({
    { name = "nvim_lsp", max_item_count = 5 },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered({ border = "double" }),
  },

  experimental = {
    -- Grey preview of the top completion after the cursor as you type.
    ghost_text = true,
    native_menu = false,
  },
})
