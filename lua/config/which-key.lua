local status_ok, wk = pcall(require, "which-key")
if not status_ok then
 error("Which-Key Error")
 return
end

wk.setup()
wk.register(
    {
        ["<leader>"] = {
          b = {
            name = "Buffer",
            d = {
              name = "Delete",
            },
            p = {
              name = "Pinned",
            },
          },
          x = { name = "Trouble Diagnostics" },
          f = { name = "Find (Telescope)" },
          g = { name = "Git" },
          h = { name = "Harpoon" },
        },
   }
)
