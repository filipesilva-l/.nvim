local M = {}

M.setup = function()
	local luasnip = require("luasnip")

	luasnip.setup({})

	require("luasnip/loaders/from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })
end

return M
