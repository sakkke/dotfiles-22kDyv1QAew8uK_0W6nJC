require 'plugins'

vim.o.cursorcolumn = true
vim.o.cursorline = true
vim.o.hidden = true
vim.o.list = true
vim.o.listchars = 'eol:⏎,extends:»,nbsp:*,precedes:«,space:·,tab:»-,trail:-'
vim.o.mouse = 'a'
vim.o.number = true
vim.o.relativenumber = true
vim.o.showmode = false
vim.o.termguicolors = true
vim.o.whichwrap = vim.o.whichwrap..',h,l'
vim.o.wrap = false
vim.g.mapleader = ' '
vim.cmd [[colorscheme nord]]

-- Emack like
vim.api.nvim_set_keymap('c', '<C-a>', '<Home>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-b>', '<Left>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-d>', '<Del>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-e>', '<End>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-f>', '<Right>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-h>', '<BS>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-n>', '<Down>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-p>', '<Up>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-a>', '<Home>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-b>', '<Left>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-d>', '<Del>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-e>', '<End>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-f>', '<Right>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-h>', '<BS>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-n>', '<Down>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-p>', '<Up>', {noremap = true})

-- Shortcuts
vim.api.nvim_set_keymap('c', 'jj', '<C-c>', {noremap = true})
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {noremap = true})
vim.api.nvim_set_keymap('n', '<CR>', ':', {noremap = true})
vim.api.nvim_set_keymap('n', 'H', '^', {noremap = true})
vim.api.nvim_set_keymap('n', 'J', 'G', {noremap = true})
vim.api.nvim_set_keymap('n', 'K', 'gg', {noremap = true})
vim.api.nvim_set_keymap('n', 'L', '$', {noremap = true})
vim.api.nvim_set_keymap('n', 'U', '<C-r>', {noremap = true})
vim.api.nvim_set_keymap('n', 'Y', 'y$', {noremap = true})
vim.api.nvim_set_keymap('v', 'v', '<Esc>', {noremap = true})

require 'init_local'
