local status_ok, nvim_treesitter_autotag = pcall(require, "nvim-ts-autotag.configs")
if not status_ok then
  return
end

nvim_treesitter_autotag.setup({
  ensure_installed = {
    -- Necessary
    "c",
    "lua",
    "vim",
    "vimdoc",
    -- Custom
    "html",
    "javascript",
    "json",
    "markdown",
    "tsx",
    "typescript",
    "yaml",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  -- Enabling nvim-ts-autotag
  autotag = {
    enable = true,
  },
})
