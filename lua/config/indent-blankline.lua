local status_ok, indent = pcall(require, "ibl")
if not status_ok then
  error("Indent Blankline Error")
  return
end

indent.setup({
  space_char_blankline = " ",
  show_current_context = true,
  filetype_exclude = {
    "help",
    "alpha",
    "dashboard",
    "neo-tree",
    "Trouble",
    "lazy",
    "mason",
    "notify",
    "toggleterm",
    "lazyterm",
  },
})
