local M = {}

M.setup = function()
	require("nvim-tree").setup({
		view = {
			mappings = {
				list = {
					{ key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
					{ key = "h", action = "close_node" },
					{ key = "v", action = "vsplit" },
					{ key = "s", action = "split" },
					{ key = "e", action = "" },
				},
			},
		},
		actions = {
			change_dir = {
				enable = false,
			},
			open_file = {
				quit_on_open = true,
			},
		},
	})
end

return M
