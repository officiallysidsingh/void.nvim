local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

local map = require("helpers.keys").map

map( "n", "<leader>ha", mark.add_file, "[H]arpoon [A]dd File" )
map( "n", "<leader>hs", ui.toggle_quick_menu, "[H]arpoon [S]how File" )

map( "n", "<M-j>", function() ui.nav_file(1) end, "First Harpoon File" )
map( "n", "<M-k>", function() ui.nav_file(2) end, "Second Harpoon File" )
