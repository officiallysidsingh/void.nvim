local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
    error("Neo Tree Error")
    return
end

neotree.setup({
    hide_root_node = true,
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
    window = {
        width = 30,
        mappings = {
            ["<space>"] = "none",
            ["h"] = "open",
        },
    },
    event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            -- auto close
            vim.cmd("Neotree close")
          end
        },
    },
    default_component_configs = {
        indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
        },
        git_status = {
            symbols = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
            }
        },
    },
    filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
    },
})