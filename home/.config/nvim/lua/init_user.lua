vim.cmd [[
  augroup user_config
    autocmd!
    autocmd BufEnter * checktime
    autocmd BufWritePost init_user.lua source <afile>
  augroup end
]]

vim.o.autoread = true
vim.o.clipboard = 'unnamedplus'
vim.o.cursorcolumn = true
vim.o.cursorline = true
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.list = true
vim.o.listchars = 'eol:⏎,extends:»,nbsp:*,precedes:«,space:·,tab:»-,trail:-'
vim.o.mouse = 'a'
vim.o.nrformats = 'bin,hex,alpha' -- vim.o.nrformats..',alpha'
vim.o.number = true
vim.o.relativenumber = true
vim.o.showmode = false
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.virtualedit = 'onemore'
vim.o.whichwrap = 'b,s,h,l' -- vim.o.whichwrap..',h,l'
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Emack like
vim.api.nvim_set_keymap('c', '<C-a>', '<Home>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-b>', '<Left>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-d>', '<Del>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-e>', '<End>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-f>', '<Right>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-h>', '<BS>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-n>', 'g<Down>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-p>', 'g<Up>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-a>', '<Home>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-b>', '<Left>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-d>', '<Del>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-e>', '<End>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-f>', '<Right>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-h>', '<BS>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-n>', '<C-o>g<Down>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-p>', '<C-o>g<Up>', {noremap = true})

-- Remaps
vim.api.nvim_set_keymap('n', '$', 'g$', {})
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true})

-- Shortcuts
vim.api.nvim_set_keymap('c', 'jj', '<C-c>', {noremap = true})
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {noremap = true})
vim.api.nvim_set_keymap('n', '<CR>', ':', {noremap = true})
vim.api.nvim_set_keymap('n', 'H', '^', {noremap = true})
vim.api.nvim_set_keymap('n', 'J', 'G', {noremap = true})
vim.api.nvim_set_keymap('n', 'K', 'gg', {noremap = true})
vim.api.nvim_set_keymap('n', 'L', 'g$', {noremap = true})
vim.api.nvim_set_keymap('n', 'U', '<C-r>', {noremap = true})
vim.api.nvim_set_keymap('n', 'Y', 'y$', {noremap = true})
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true})
vim.api.nvim_set_keymap('v', 'H', '^', {noremap = true})
vim.api.nvim_set_keymap('v', 'J', 'G', {noremap = true})
vim.api.nvim_set_keymap('v', 'K', 'gg', {noremap = true})
vim.api.nvim_set_keymap('v', 'L', 'g$', {noremap = true})
vim.api.nvim_set_keymap('v', 'v', '<Esc>', {noremap = true})

-- new maps
vim.api.nvim_set_keymap('x', '<Leader>ca', ':sort<CR>', {noremap = true})
vim.api.nvim_set_keymap('x', '<Leader>cz', ':sort!<CR>', {noremap = true})

-- vim: et sw=2
