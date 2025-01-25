local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end
local dashboard = require("alpha.themes.dashboard")

-- Set Header Value
dashboard.section.header.val = {
  "                                                                             ",
  "                   ▄▀▀▄ ▄▀▀▄  ▄▀▀▀▀▄   ▄▀▀█▀▄    ▄▀▀█▄▄                      ",
  "                  █  █    █ █      █ █   █  █  █ ▄▀   █                      ",
  "                  ▐  █    █  █      █ ▐   █  ▐  ▐ █    █                     ",
  "                     █   ▄▀  ▀▄    ▄▀     █       █    █                     ",
  "                      ▀▄▀      ▀▀▀▀    ▄▀▀▀▀▀▄   ▄▀▄▄▄▄▀                     ",
  "                                      █       █ █     ▐                      ",
  "                                      ▐       ▐ ▐                            ",
  "                                                                             ",
  "                                                                             ",
  "                     ███╗   ██╗ ██╗   ██╗ ██╗ ███╗   ███╗                    ",
  "                     ████╗  ██║ ██║   ██║ ██║ ████╗ ████║                    ",
  "                     ██╔██╗ ██║ ██║   ██║ ██║ ██╔████╔██║                    ",
  "                     ██║╚██╗██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║                    ",
  "                     ██║ ╚████║  ╚████╔╝  ██║ ██║ ╚═╝ ██║                    ",
  "                     ╚═╝  ╚═══╝   ╚═══╝   ╚═╝ ╚═╝     ╚═╝                    ",
}

-- Set Header Highlights
dashboard.section.header.opts.hl = "AlphaHeader"

-- Set Buttons Value
dashboard.section.buttons.val = {
  dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
  dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
  dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
  dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
  dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}

-- Set Buttons Highlights
for _, button in ipairs(dashboard.section.buttons.val) do
  button.opts.hl = "AlphaButtons"
  button.opts.hl_shortcut = "AlphaShortcut"
end
dashboard.section.buttons.opts.hl = "AlphaButtons"

-- Set Footer Value
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
    pcall(vim.cmd.AlphaRedraw)
  end,
})

-- Set Footer Highlights
dashboard.section.footer.opts.hl = "AlphaFooter"

-- Disable folding on alpha buffer
vim.cmd([[
  autocmd FileType alpha setlocal nofoldenable
]])

-- Send config to Alpha
alpha.setup(dashboard.opts)
