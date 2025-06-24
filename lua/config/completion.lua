local map = require("helpers.keys").map

local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
  error("Cmp Error")
  return
end

local status_ok_luasnip, luasnip = pcall(require, "luasnip")
if not status_ok_luasnip then
  error("Luasnip Error")
  return
end

local status_ok_luasnip_loaders, luasnip_loaders = pcall(require, "luasnip.loaders.from_vscode")
if not status_ok_luasnip_loaders then
  error("Luasnip Loaders Error")
  return
end

--- Luasnip Config ---

-- Load VSCode Style Snippets
luasnip_loaders.lazy_load()

-- In Insert Mode, Jump To Next Snippet Or Insert A Tab
map("i", "<Tab>", function()
  return luasnip.jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
end)

-- In Select Mode, Jump To Next Snippet
map("s", "<Tab>", function()
  luasnip.jump(1)
end)

-- In Insert And Select Modes, Jump To Previous Snippet
map({ "i", "s" }, "<S-Tab>", function()
  luasnip.jump(-1)
end)

--- CMP Config ---

cmp.setup({
  -- Opts For Insert Mode Autocompletion
  completion = {
    completeopt = "fuzzy,menu,menuone,noinsert,preview",
  },

  -- Config For Nvim-Cmp Interaction With Snippet Engines
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    -- To Select Next And Prev Items In Completion
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),

    -- To Close Completion Window
    ["<C-e>"] = cmp.mapping.abort(),

    -- To Accept Currently Selected Item.
    ["<CR>"] = cmp.mapping.confirm({ select = false }),

    -- To Scroll Docs
    ["<C-d>"] = cmp.mapping(function()
      cmp.scroll_docs(4)
    end, { "i" }),

    ["<C-u>"] = cmp.mapping(function()
      cmp.scroll_docs(-4)
    end, { "i" }),

    -- To Open and Close Docs
    ["<C-x>"] = cmp.mapping(function()
      if cmp.visible_docs() then
        cmp.close_docs()
      else
        cmp.open_docs()
      end
    end, { "i" }),
  }),

  -- Sources For Autocompletion
  sources = cmp.config.sources({
    { name = "nvim_lsp", max_item_count = 5 }, -- For LSP
    { name = "luasnip" }, -- For Snippets
    { name = "buffer" }, -- For Current Buffer Text
    { name = "path" }, -- For File System Path
  }),

  -- Window Settings
  window = {
    -- Completion Window Settings
    completion = cmp.config.window.bordered(),

    -- Documentation Window Settings
    documentation = cmp.config.window.bordered({
      border = "double",
    }),
  },

  experimental = {
    ghost_text = true,
    native_menu = false,
  },
})
