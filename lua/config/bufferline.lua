local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
 error("BufferLine Error")
 return
end

bufferline.setup({
    options = {
        separator_style = "slant",
        always_show_bufferline = false,
        indicator = {
            style = 'underline',
        },
        diagnostics = "nvim_lsp",
        
        diagnostics_indicator = function(_, _, diag)
            local icons = require("lazyvim.config").icons.diagnostics
            local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                .. (diag.warning and icons.Warn .. diag.warning or "")
            return vim.trim(ret)
        end,
        
        offsets = {
            {
                filetype = "neo-tree",
                text = "Neo-tree",
                highlight = "Directory",
                text_align = "center",
                separator = true,
            },
        },
        show_buffer_icons = false,
        modified_icon = '●',
        show_close_icon = false,
        show_buffer_close_icons = false,
    }
})