vim = vim

vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.swapfile = false
vim.o.winborder = 'single' 

vim.g.mapleader = " "

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')

vim.pack.add({
	{ src = 'https://github.com/vague2k/vague.nvim' },
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/echasnovski/mini.nvim' },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
})

require 'mason'.setup()
require 'mini.pick'.setup()
require 'oil'.setup()

vim.lsp.enable({ "emmylua_ls" })

vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')

vim.keymap.set('n', '<leader>e', ':Oil<CR>')

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.cmd("colorscheme vague")
