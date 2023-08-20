# To Add A Language
1. Go To The config/lsp.lua file and add its LSP to ensure installed list of lsp.
This will download the lsp to your environment and configure its path to make it discoverable using the mason.nvim plugin.

2. Next, In the same file, go to the section for setting up the lsp. Setup your lsp using docs of nvim-lspconfig.
This will use the lsp downloaded in previous step and run it.

3. For additional formatting and diagonostics, go to config/null-ls.lua file and add in your formatting source in the source table.
(NOTE - Do download the source you are adding. Eg - Prettier)
