local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
  error("Cmp Error")
  return
end

local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
  error("Luasnip Error")
  return
end

local icons = {
  Array = " ",
  Boolean = " ",
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Copilot = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = " ",
  Key = " ",
  Keyword = " ",
  Method = " ",
  Module = " ",
  Namespace = " ",
  Null = " ",
  Number = " ",
  Object = " ",
  Operator = " ",
  Package = " ",
  Property = " ",
  Reference = " ",
  Snippet = " ",
  String = " ",
  Struct = " ",
  Text = " ",
  TypeParameter = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

cmp.setup({
  completion = {
    completeopt = "menu,menuone,noinsert",
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    -- To Close cmp
    ["<C-i>"] = cmp.mapping.abort(),

    -- To Open and Close Docs
    ["<C-x>"] = cmp.mapping(function()
      if cmp.visible_docs() then
        cmp.close_docs()
      else
        cmp.open_docs()
      end
    end, { "i" }),

    -- To Scroll Docs
    ["<C-n>"] = cmp.mapping.scroll_docs(4),
    ["<C-p>"] = cmp.mapping.scroll_docs(-4),

    -- To Select Next And Prev Items In Completion
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),

    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = true }),

    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp", max_item_count = 5 },
    { name = "luasnip" },
    { name = "buffer",   keyword_length = 6 },
    { name = "path" },
  }),

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(_, item)
      if icons[item.kind] then
        item.menu = item.kind
        item.kind = icons[item.kind]
      end
      return item
    end,
  },

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
