local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use {
    'akinsho/bufferline.nvim',
    config = function () require('bufferline').setup {} end,
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use {'arcticicestudio/nord-vim', requires = {'tribela/vim-transparent'}}
  use 'editorconfig/editorconfig-vim'
  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup {}
    end,
  }
  use {
    'hoob3rt/lualine.nvim',
    config = function ()
      require('lualine').setup {
        options = {theme = 'nord'},
      }
    end,
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
  }
  use 'lambdalisue/gina.vim'
  use {
    'notomo/gesture.nvim',
    config = function()
      vim.api.nvim_set_keymap('n', '<LeftDrag>', '<Cmd>lua require("gesture").draw()<CR>', {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<LeftRelease>', '<Cmd>lua require("gesture").finish()<CR>', {noremap = true, silent = true})
      local gesture = require 'gesture'
      gesture.register {
        name = 'Gina commit',
        inputs = {gesture.left(), gesture.down(), gesture.right()},
        action = 'Gina --opener=tabnew commit',
      }
      gesture.register {
        name = 'Gina status',
        inputs = {gesture.down(), gesture.right(), gesture.down()},
        action = 'Gina --opener=tabnew status -s',
      }
    end,
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup {
        highlight = {enable = true},
      }
    end,
    run = ':TSUpdate',
  }
  use {'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup {} end}
end)
