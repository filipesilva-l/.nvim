local M = {}

local lsp_component = {
	function(msg)
		msg = msg or "LS Inactive"
		local buf_clients = vim.lsp.buf_get_clients()
		if next(buf_clients) == nil then
			if type(msg) == "boolean" or #msg == 0 then
				return "LS Inactive"
			end
			return msg
		end

		return ""
	end,
	color = { gui = "bold" },
}

M.setup = function()
	require("lualine").setup({
		options = {
			theme = "gruvbox-material",
			section_separators = "",
			component_separators = "",
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { "filename" },
			lualine_x = { "filetype" },
			lualine_y = {
				lsp_component,
			},
			lualine_z = {},
		},
	})
end

return M
