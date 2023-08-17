local status_ok, wk = pcall(require, "which-key")
if not status_ok then
 error("Which-Key Error")
 return
end

wk.setup()
wk.register(
    {
        ["<leader>"] = {
          d = { name = "Delete" },
          x = { name = "Trouble Diagnostics" },
          f = { name = "Telescope" },
        }
    }
)
