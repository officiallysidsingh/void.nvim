-- Which-key: pops up after pressing a prefix (e.g. <leader>) to show every
-- mapping that starts with it. Each mapping's `desc` is what's shown here,
-- which is why every map helper takes a desc string.

local wk = require("which-key")

wk.setup({
  plugins = {
    marks = true, -- Show `'` marks popup
    registers = true, -- Show `"` registers popup
    spelling = { enabled = true, suggestions = 20 }, -- Suggestions on z=
  },
  icons = {
    breadcrumb = "»",
    separator = "",
    group = " ",
  },
  -- Rewrite how certain keys are rendered in the popup.
  replace = {
    key = {
      -- `<Space>` is our leader; "SPC" reads better in the group listing.
      { "<Space>", "SPC" },
    },
  },
})

-- Give each leader-prefix a group name. Which-key still renders the
-- individual mappings; this just labels the folder.
wk.add({
  { "<leader>b", group = "[B]uffer" },
  { "<leader>bd", group = "[D]elete" },
  { "<leader>c", group = "[C]ode" },
  { "<leader>d", group = "[D]ebug" },
  { "<leader>f", group = "[F]ind" },
  { "<leader>g", group = "[G]it" },
  { "<leader>n", group = "[N]eotest / [N]otifications" },
  { "<leader>r", group = "[R]estart" },
  { "<leader>s", group = "[S]earch / Replace" },
  { "<leader>x", group = "Diagnostics (Trouble)" },
})
