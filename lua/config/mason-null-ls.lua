local status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not status_ok then
	error("Mason Null-Ls Error")
	return
end

-- Sources For Null-Ls
local sources = {
	ensure_installed = {
		-- Golang
		"gofumpt",
		"goimports",
		"golines",

		-- Web Development(FrontEnd)
		"prettierd",
		"eslint_d",

		-- Lua
		"stylua",
	},
}

mason_null_ls.setup(sources)
