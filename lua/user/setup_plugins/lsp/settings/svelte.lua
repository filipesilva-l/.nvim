local lsp_default = require("user.setup_plugins.lsp")

return {
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		lsp_default.on_attach(client, bufnr)
	end,
}
