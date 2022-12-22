local M = {}

local get_diagnostic = function()
	local config = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		format = function(d)
			local code = d.code or (d.user_data and d.user_data.lsp.code)
			if code then
				return string.format("%s [%s]", d.message, code):gsub("1. ", "")
			end
			return d.message
		end,
	}

	config.scope = "line"

	vim.diagnostic.open_float(0, config)
end

local opts = { noremap = true, silent = true }

M.on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<Leader>la", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<Leader>ls", ":Telescope lsp_document_symbols<CR>", bufopts)
	vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "gl", get_diagnostic, bufopts)

	if client.server_capabilities.signatureHelpProvider then
		require("lsp-overloads").setup(client, {})
	end
end

M.setup = function()
	local mason_lspconfig = require("mason-lspconfig")
	local lspconfig = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	mason_lspconfig.setup({
		ensure_installed = { "sumneko_lua", "rust_analyzer" },
	})

	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

	mason_lspconfig.setup_handlers({
		function(server_name)
			local opts_lsp = {
				on_attach = M.on_attach,
				capabilities = capabilities,
			}

			local require_ok, server = pcall(require, "user.setup_plugins.lsp.settings." .. server_name)
			if require_ok then
				opts_lsp = vim.tbl_deep_extend("force", server, opts_lsp)
			end

			lspconfig[server_name].setup(opts_lsp)
		end,
	})
end

return M
