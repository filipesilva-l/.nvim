local opts = { silent = true, noremap = true }
local command_opts = { expr = true }
local fn = vim.fn

local modes = {
	normal_mode = "n",
	insert_mode = "i",
	terminal_mode = "t",
	visual_mode = "v",
	visual_block_mode = "x",
	command_mode = "c",
}

local function forward_search()
	if fn.getcmdtype() == "/" or fn.getcmdtype() == "?" then
		return "<CR>/<C-r>/"
	end
	return "<C-z>"
end

local function backward_search()
	if fn.getcmdtype() == "/" or fn.getcmdtype() == "?" then
		return "<CR>?<C-r>/"
	end
	return "<S-Tab>"
end

local keymaps = {
	normal_mode = {
		-- Better window navigation
		["<C-j>"] = "<C-w>j",
		["<C-k>"] = "<C-w>k",
		["<C-h>"] = "<C-w>h",
		["<C-l>"] = "<C-w>l",
		-- Move Next Window
		["<Leader>w"] = ":w<CR>",
		["<Leader>q"] = ":q<CR>",
		["<Leader>h"] = ":nohl<CR>",
		["<Leader>f"] = ":Telescope find_files<CR>",
		["<Leader>st"] = ":Telescope live_grep<CR>",
		["<Leader>sp"] = ":Telescope colorscheme<CR>",
		["<Leader>e"] = ":NvimTreeFindFileToggle<CR>",
		-- Resize with arrows
		["<C-Up>"] = ":resize +2<CR>",
		["<C-Down>"] = ":resize -2<CR>",
		["<C-Left>"] = ":vertical resize +2<CR>",
		["<C-Right>"] = ":vertical resize -2<CR>",
		-- Navigate buffers
		["L"] = ":bnext<CR>",
		["H"] = ":bprevious<CR>",
		["<Leader>c"] = ":bdelete<CR>",
		-- Indent lines
		["<"] = "<<",
		[">"] = ">>",
		-- Hop
		["s"] = ":HopChar2<cr>",
		["S"] = ":HopWord<cr>",
		-- Vertical navigation
		["<C-d>"] = "<C-d>zz",
		["<C-u>"] = "<C-u>zz",
		-- Move text up and down
		["<A-j>"] = ":m .+1<CR>==",
		["<A-k>"] = ":m .-2<CR>==",
		-- Harpoon
		["<Leader><Leader>r"] = "<cmd>lua require('harpoon.mark').clear_all()<CR>",
		["<Leader><Leader>f"] = "<cmd>lua require('harpoon.mark').add_file()<CR>",
		["<Leader><Leader>g"] = "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
		["<Leader><Leader>h"] = "<cmd>lua require('harpoon.ui').nav_file(1)<CR>",
		["<Leader><Leader>j"] = "<cmd>lua require('harpoon.ui').nav_file(2)<CR>",
		["<Leader><Leader>k"] = "<cmd>lua require('harpoon.ui').nav_file(3)<CR>",
		["<Leader><Leader>l"] = "<cmd>lua require('harpoon.ui').nav_file(4)<CR>",
	},
	insert_mode = {
		-- Move text up and down
		["<A-j>"] = "<Esc>:m .+1<CR>==gi",
		["<A-k>"] = "<Esc>:m .-2<CR>==gi",
	},
	terminal_mode = {
		-- Terminal Navigation
		["C-j"] = "<C-\\><C-n><C-W>j",
		["C-k"] = "<C-\\><C-n><C-W>k",
		["C-h"] = "<C-\\><C-n><C-W>h",
		["C-l"] = "<C-\\><C-n><C-W>l",
		-- exit other modes
		["<Esc>"] = "<C-\\><C-n>",
	},
	visual_mode = {
		-- Better Paste
		["p"] = '"_dP',
		-- Indent lines
		["<"] = "<gv",
		[">"] = ">gv",
		-- Move text up and down
		["<A-j>"] = ":m '>+1<CR>gv=gv",
		["<A-k>"] = ":m '<-2<CR>gv=gv",
	},
	visual_block_mode = {
		-- Move text up and down
		["<A-j>"] = ":m '>+1<CR>gv=gv",
		["<A-k>"] = ":m '<-2<CR>gv=gv",
	},
	command_mode = {
		-- Word Search Increment and Decrement
		["<Tab>"] = forward_search,
		["<S-Tab>"] = backward_search,
	},
}

for i, k in pairs(keymaps.normal_mode) do
	vim.keymap.set(modes.normal_mode, i, k, opts)
end

for i, k in pairs(keymaps.insert_mode) do
	vim.keymap.set(modes.insert_mode, i, k, opts)
end

for i, k in pairs(keymaps.terminal_mode) do
	vim.keymap.set(modes.terminal_mode, i, k, opts)
end

for i, k in pairs(keymaps.visual_mode) do
	vim.keymap.set(modes.visual_mode, i, k, opts)
end

for i, k in pairs(keymaps.visual_block_mode) do
	vim.keymap.set(modes.visual_block_mode, i, k, opts)
end

for i, k in pairs(keymaps.command_mode) do
	vim.keymap.set(modes.command_mode, i, k, command_opts)
end
