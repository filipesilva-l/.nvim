local M = {}

M.setup = function()
	require("alpha").setup(require("alpha.themes.dashboard").config)
end

return M
