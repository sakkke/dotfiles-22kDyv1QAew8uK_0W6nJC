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
  use 'arcticicestudio/nord-vim'
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
          l = {'<Cmd>Gina --opener=tabnew log<CR>', 'log'},
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
        r = {'<Cmd>redraw!<CR>', 'redraw!'},
        t = {
          name = 'toggle',
          g = {'<Cmd>Goyo<CR>', 'Goyo'},
          l = {'<Cmd>Limelight!!<CR>', 'Limelight'},
          t = {'<Cmd>NvimTreeToggle<CR>', 'NvimTree'},
        },
        w = {'<Cmd>w<CR>', 'write'},
        z = {'zz', 'zz'},
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
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
    requires = {
      'nvim-lua/plenary.nvim',
    },
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.cmd [[
        highlight IndentBlanklineIndent1 guifg=#bf616a blend=nocombine " nord11
        highlight IndentBlanklineIndent2 guifg=#d08770 blend=nocombine " nord12
        highlight IndentBlanklineIndent3 guifg=#ebcb8b blend=nocombine " nord13
        highlight IndentBlanklineIndent4 guifg=#a3be8c blend=nocombine " nord14
        highlight IndentBlanklineIndent5 guifg=#b48ead blend=nocombine " nord15
      ]]
      require('indent_blankline').setup {
        char_highlight_list = {
          'IndentBlanklineIndent1',
          'IndentBlanklineIndent2',
          'IndentBlanklineIndent3',
          'IndentBlanklineIndent4',
          'IndentBlanklineIndent5',
        },
      }
    end,
  }
  use 'junegunn/goyo.vim'
  use {
    'junegunn/limelight.vim',
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>l', '<Plug>(Limelight)', {})
      vim.api.nvim_set_keymap('x', '<Leader>l', '<Plug>(Limelight)', {})
      function limelightWrapper(bool)
        if (
          (
            vim.fn.exists('g:clear_background') and
            vim.g.clear_background == 0
          ) or
          not vim.fn.exists('g:clear_background') and
          bool
        ) then
          vim.cmd [[Limelight]]
        else
          vim.cmd [[Limelight!]]
        end
      end
      vim.cmd [[autocmd! User GoyoEnter call v:lua.limelightWrapper(v:true)]]
      vim.cmd [[autocmd! User GoyoLeave call v:lua.limelightWrapper(v:false)]]
    end,
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
        rainbow = {
          enable = true,
        },
      }
    end,
    requires = {
      'p00f/nvim-ts-rainbow',
    },
    run = ':TSUpdate',
  }
  use {'tribela/vim-transparent', opt = true}
  use 'vim-jp/vimdoc-ja'
  use {
    'voldikss/vim-floaterm',
    config = function()
      vim.g.floaterm_keymap_first = ']]0'
      vim.g.floaterm_keymap_hide = ']]d'
      vim.g.floaterm_keymap_kill = ']]x'
      vim.g.floaterm_keymap_last = ']]l'
      vim.g.floaterm_keymap_new = ']]c'
      vim.g.floaterm_keymap_next = ']]n'
      vim.g.floaterm_keymap_prev = ']]p'
      vim.g.floaterm_keymap_show = ']]a'
      vim.g.floaterm_keymap_toggle = ']]t'
    end,
  }
  use {'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup {} end}
end)
