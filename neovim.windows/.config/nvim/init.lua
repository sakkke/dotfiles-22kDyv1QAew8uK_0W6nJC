require 'plugins'
vim.o.list = true
vim.o.listchars = 'eol:↵,extends:»,nbsp:*,precedes:«,space:·,tab:»-,trail:-'
vim.o.number = true
vim.o.relativenumber = true
vim.api.nvim_set_keymap('v', '<Leader>B', [[c<C-r>=system('base64 -d', @")<CR><Esc>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>b', [[c<C-r>=system('base64 -w0', @")<CR><Esc>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', 'jj', '<C-c>', { noremap = true })
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true })
vim.cmd[[silent! colorscheme catppuccin]]
