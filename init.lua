-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	-- LSP support
	{
		"neovim/nvim-lspconfig",
	},

	-- Autocomplete
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
	},

	-- LSP manager
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
	},

	{
		"tpope/vim-fugitive",
	},

	{
		"airblade/vim-gitgutter",
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"preservim/nerdtree",
	},

	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight")
		end,
	},
})

require("nvim-treesitter").setup({
	highlight = {
		enable = true,
	},
})

local cmp = require("cmp")

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),

	sources = {
		{ name = "nvim_lsp" },
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"jdtls",
		"clangd",
		"pylsp",
	},
})


-- ### Keymaps ###
vim.keymap.set("n", "om", ":lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "ln", ":set nu<CR>")
vim.keymap.set("n", "nn", ":set nonu<CR>")

-- NERDTree
vim.keymap.set("n", "<C-n>", ":NERDTreeToggle<CR>")

-- Tabs
vim.keymap.set("n", "<C-w>n", ":tabnew<CR>")
vim.keymap.set("n", "<C-w>r", ":tabmove +1<CR>")
vim.keymap.set("n", "<C-w>l", ":tabmove -1<CR>")

-- Settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

vim.opt.number = true
