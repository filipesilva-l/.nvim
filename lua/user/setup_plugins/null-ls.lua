local M = {}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.setup = function()
	local null_ls = require("null-ls")
	local formatting = null_ls.builtins.formatting

	local prettier = formatting.prettier.with({
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"css",
			"scss",
			"less",
			"html",
			"json",
			"jsonc",
			"yaml",
			"markdown",
			"graphql",
			"handlebars",
			"svelte",
		},
	})

	null_ls.setup({
		sources = {
			prettier,
			formatting.stylua,
		},
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format()
					end,
				})
			end
		end,
		debug = true,
	})
end

return M
