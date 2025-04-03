local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  error("Which-Key Error")
  return
end

-- Setup `which-key` with configurations
wk.setup({
  plugins = {
    marks = true,
    registers = true,
    spelling = { enabled = true, suggestions = 20 },
  },
  icons = {
    breadcrumb = "»",
    separator = "",
    group = " ",
  },
  replace = {
    ["<leader>"] = "SPC",
  },
})

-- Add key mappings with groups
wk.add({
  -- Lazy
  { "<leader>l", group = "[L]azy" },

  -- Yank
  { "<leader>y", group = "[Y]ank To System Clipboard" },

  -- Buffers
  { "<leader>b", group = "[B]uffer" },
  { "<leader>bd", group = "[D]elete" },
  { "<leader>bp", group = "[P]in" },
  { "<leader>bs", group = "[S]how" },

  -- Telescope Finder
  { "<leader>f", group = "[F]ind" },
  { "<leader>ft", group = "[T]odo" },
  { "<leader>/", group = "Find Text In CWD" },
  { "<leader><space>", group = "Find Files" },

  -- Git
  { "<leader>g", group = "[G]it" },
  { "<leader>gb", group = "[B]ranches" },

  -- Mason
  { "<leader>m", group = "[M]ason" },

  -- Undotree
  { "<leader>u", group = "[U]ndotree" },

  -- Quit
  { "<leader>q", group = "[Q]uit" },
})
