local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
 error("BufferLine Error")
 return
end

lualine.setup({
  options = {
    theme = "auto",
    globalstatus = true,
    disabled_filetypes = {
      statusline = {
        "dashboard",
        "alpha"
      }
    },
  },
  sections = {
    lualine_a = {
      "mode"
    },
    lualine_b = {
      "branch"
    },
    lualine_c = {
      {
        "diagnostics",
        symbols = {
          error = " ",
          warn = " ",
          info = " ",
          hint = " ",
        },
       },
       {
         "filetype",
         icon_only = true,
         separator = "",
         padding = {
           left = 1,
           right = 0
         }
       },
       {
         "filename",
         path = 1,
         symbols = {
           modified = "  ",
           readonly = "",
           unnamed = ""
         }
       },
     },
     lualine_x = {
       -- stylua: ignore
       {
          "diff",
          symbols = {
            added = " ",
            modified = " ",
            removed = " ",
          },
        },
      },
      lualine_y = {
        {
          "progress",
          separator = " ",
          padding = {
            left = 1,
            right = 0
          }
        },
        {
          "location",
          padding = {
            left = 0,
            right = 1
          }
        },
      },
      lualine_z = {
        function()
          return " " .. os.date("%I:%M %p")
        end,
      },
    },
    extensions = {
      "neo-tree",
      "lazy"
    }
})
