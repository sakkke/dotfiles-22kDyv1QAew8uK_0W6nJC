local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

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
      local wk = require 'which-key'
      wk.register({
        Q = {'<Cmd>qa!<CR>', 'quitall!'},
        W = {'<Cmd>wq<CR>', 'wq'},
        [' '] = {
          name = 'Telescope',
          [' '] = {'<Cmd>Telescope<CR>', 'Telescope'},
          b = {'<Cmd>Telescope buffers<CR>', 'buffers'},
          c = {'<Cmd>Telescope command_history<CR>', 'command_history'},
          m = {'<Cmd>Telescope coc mru<CR>', 'mru'},
          r = {'<Cmd>Telescope registers<CR>', 'registers'},
          s = {'<Cmd>Telescope search_history<CR>', 'search_history'},
        },
        f = {
          name = 'focus',
          t = {'<Cmd>NvimTreeFocus<CR>', 'NvimTree'},
        },
        g = {
          name = 'git',
          c = {'<Cmd>Gina --opener=tabnew commit<CR>', 'commit'},
          s = {'<Cmd>Gina --opener=tabnew status -s<CR>', 'status'},
        },
        p = {
          name = 'Packer',
          c = {'<Cmd>PackerClean<CR>', 'Clean'},
          i = {'<Cmd>PackerInstall<CR>', 'Install'},
          o = {'<Cmd>PackerCompile<CR>', 'Compile'},
          s = {'<Cmd>PackerStatus<CR>', 'Status'},
          u = {'<Cmd>PackerUpdate<CR>', 'Update'},
          y = {'<Cmd>PackerSync<CR>', 'Sync'},
        },
        q = {'<Cmd>q<CR>', 'quit'},
        t = {
          name = 'toggle',
          t = {'<Cmd>NvimTreeToggle<CR>', 'NvimTree'},
        },
        w = {'<Cmd>w<CR>', 'write'},
      }, {prefix = '<Leader>'})
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
  use {
    'kana/vim-textobj-user',
    requires = {
      'glts/vim-textobj-indblock', -- `ao`/`io`
      'kana/vim-textobj-indent', -- `ai`/`ii`,`aI`,`iI`
      'kana/vim-textobj-syntax', -- `ay`/`iy`
      'mattn/vim-textobj-url', -- `au`/`iu`
    },
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use 'lambdalisue/gina.vim'
  use {
    'neoclide/coc.nvim',
    branch = 'release',
    requires = {
      {'neoclide/coc-lists', run = 'yarn install --flozen-lockfile'},
    },
  }
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
    'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').load_extension('coc')
    end,
    requires = {
      'fannheyward/telescope-coc.nvim',
      'nvim-lua/plenary.nvim',
    },
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
