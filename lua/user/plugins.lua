vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- packer
	use("wbthomason/packer.nvim")

	-- random
	use("eandrju/cellular-automaton.nvim")

	-- utils
	use("nvim-lua/plenary.nvim")

	use("nvim-lua/popup.nvim")

	use("nvim-telescope/telescope.nvim")

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({})
		end,
	})

	use({
		"lewis6991/impatient.nvim",
		config = function()
			require("impatient")
		end,
	})

	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	})

	use("tpope/vim-abolish")

	-- line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-lua/lsp-status.nvim" },
		config = function()
			require("user.setup_plugins.lualine").setup()
		end,
	})

	-- moviments
	use({
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("user.setup_plugins.hop").setup()
		end,
	})

	use({ "ThePrimeagen/harpoon" })

	-- tree explorer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("user.setup_plugins.nvim-tree").setup()
		end,
	})

	-- snippets
	use({
		"L3MON4D3/LuaSnip",
		config = function()
			require("user.setup_plugins.luasnip").setup()
		end,
	})

	-- lsp
	use({
		{
			"williamboman/mason.nvim",
			config = function()
				require("mason").setup()
			end,
		},
		{
			"williamboman/mason-lspconfig.nvim",
			config = function()
				require("user.setup_plugins.lsp").setup()
			end,
			requires = { "nvim-cmp" },
		},
		"neovim/nvim-lspconfig",
	})

	use({
		"lukas-reineke/lsp-format.nvim",
		config = function()
			require("lsp-format").setup()
			require("lspconfig").gopls.setup({ on_attach = require("lsp-format").on_attach })
		end,
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "lukas-reineke/lsp-format.nvim" },
		config = function()
			require("user.setup_plugins.null-ls").setup()
		end,
	})

	use({
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup()
		end,
	})

	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({})
		end,
	})

	use({ "Issafalcon/lsp-overloads.nvim" })

	-- cmp
	use({
		"hrsh7th/nvim-cmp",
		requires = { "L3MON4D3/LuaSnip" },
		config = function()
			require("user.setup_plugins.cmp").setup()
		end,
	})

	use({
		"hrsh7th/cmp-nvim-lsp",
		requires = { "hrsh7th/nvim-cmp" },
	})

	use("saadparwaiz1/cmp_luasnip")

	use("hrsh7th/cmp-path")

	-- git
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	})

	use("TimUntersberger/neogit")

	-- themes
	use("sainnhe/gruvbox-material")
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("catppuccin").setup({
				transparent_background = false,
			})
		end,
	})

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("user.setup_plugins.treesitter").setup()
		end,
	})

	-- quick fix
	use({ "kevinhwang91/nvim-bqf", ft = "qf" })

	-- background transparent
	use({
		"xiyaowong/nvim-transparent",
		config = function()
			require("transparent").setup({
				enable = true,
			})
		end,
	})

	-- alpha
	use({
		"goolord/alpha-nvim",
		config = function()
			require("user.setup_plugins.alpha").setup()
		end,
	})
end)
