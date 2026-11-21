-- nvim-treesitter (main branch): parser installer + per-buffer highlighter.
--
-- The rewritten `main` branch is a different plugin from the old `master`:
-- it ships ONLY the parser install / query logic. Highlighting, indentation
-- and folding are now Neovim built-ins and must be started per buffer with
-- vim.treesitter.start(). This file does both:
--   1. Pre-install the parser list from config.languages.
--   2. On every FileType event, install the parser on demand and start
--      highlighting.

local treesitter = require("nvim-treesitter")
local languages = require("config.languages")

-- Parsers are compiled from C locally, so we need the tree-sitter CLI
-- on PATH. On a machine without it, highlighting still works for any
-- parser that was already built (or ships with Neovim), we just can't
-- add new ones.
local can_install = vim.fn.executable("tree-sitter") == 1

if can_install then
  -- Async install; subsequent calls are no-ops for languages already present.
  treesitter.install(languages.parsers)
end

-- `get_available()` reads from the plugin's parser registry. Lazily fetched
-- and memoized because it's a non-trivial table copy.
local available = nil

---Safely start treesitter highlighting on a buffer.
---Wrapped in pcall because the parser may error on corrupt files or buffers
---that disappeared between the FileType event and this callback firing.
local function start(buf)
  if vim.api.nvim_buf_is_valid(buf) then
    pcall(vim.treesitter.start, buf)
  end
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
  desc = "Start treesitter highlighting, installing the parser if needed",
  callback = function(args)
    -- Resolve the filetype to a treesitter language name
    -- (e.g. filetype "tex" maps to language "latex").
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang then
      return
    end

    -- Fast path: parser is already loaded (bundled with Neovim, installed
    -- earlier, or in a previous session).
    if vim.treesitter.language.add(lang) then
      start(args.buf)
      return
    end

    -- Slow path: install on demand, then start highlighting when the build
    -- finishes. Compilation can take several seconds the first time.
    if not can_install then
      return
    end
    available = available or treesitter.get_available()
    if vim.list_contains(available, lang) then
      treesitter.install(lang):await(function()
        -- `await` runs on the installer's thread; hop back to the main loop
        -- before touching buffer state.
        vim.schedule(function()
          start(args.buf)
        end)
      end)
    end
  end,
})
