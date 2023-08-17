local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
 error("Gitsigns Error")
 return
end

gitsigns.setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  on_attach = function(buffer)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
    end

    map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "[G]it [B]lame Line")
  end,
})
