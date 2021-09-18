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
  use {
    'beauwilliams/focus.nvim',
    config = function()
      require('focus').setup()
    end,
  }
  use 'editorconfig/editorconfig-vim'
  use 'fidian/hexmode'
  use {
    'folke/todo-comments.nvim',
    config = function()
      require('todo-comments').setup {}
    end,
    requires = 'nvim-lua/plenary.nvim',
  }
  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup {}
      local wk = require 'which-key'
      wk.register({
        P = {
          name = 'Packer',
          c = {'<Cmd>PackerClean<CR>', 'Clean'},
          i = {'<Cmd>PackerInstall<CR>', 'Install'},
          o = {'<Cmd>PackerCompile<CR>', 'Compile'},
          s = {'<Cmd>PackerStatus<CR>', 'Status'},
          u = {'<Cmd>PackerUpdate<CR>', 'Update'},
          y = {'<Cmd>PackerSync<CR>', 'Sync'},
        },
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
          t = {'<Cmd>TodoTelescope<CR>', 'todo'},
        },
        [','] = {
          name = 'config',
          l = {'<Cmd>FocusSplitNicely ~/.config/nvim/lua/init_local.lua<CR>', 'local'},
          p = {'<Cmd>FocusSplitNicely ~/.config/nvim/lua/plugins.lua<CR>', 'plugins'},
          u = {'<Cmd>FocusSplitNicely ~/.config/nvim/lua/init_user.lua<CR>', 'user'},
        },
        f = {
          name = 'focus',
          t = {'<Cmd>NvimTreeFocus<CR>', 'NvimTree'},
        },
        g = {
          name = 'git',
          C = {'<Cmd>Gina --opener=vsplit commit --amend<CR>', 'commit --amend'},
          P = {'<Cmd>FloatermNew --autoclose=1 git pull<CR>', 'pull'},
          R = {'<Cmd>vsplit | terminal git rebase --continue<CR>', 'rebase --continue'},
          S = {'<Cmd>Gina --opener=vsplit status -s<CR>', 'Gina status'},
          a = {'<Cmd>FloatermNew --height=0.9 --width=0.9 git add -p<CR>', 'add -p'},
          c = {'<Cmd>Gina --opener=vsplit commit<CR>', 'commit'},
          l = {'<Cmd>Gina --opener=vsplit log<CR>', 'log'},
          p = {'<Cmd>FloatermNew --autoclose=1 git push<CR>', 'push'},
          r = {'<Cmd>vsplit | terminal git rebase -i<CR>', 'rebase -i'},
          s = {'<Cmd>FloatermNew git status<CR>', 'status'},
        },
        i = {
          name = 'inv',
          N = {'<Cmd>set invrelativenumber<CR>', 'relativenumber'},
          l = {'<Cmd>set invlist<CR>', 'list'},
          n = {'<Cmd>set invnumber<CR>', 'number'},
          p = {'<Cmd>set invpaste<CR>', 'paste'},
          w = {'<Cmd>set invwrap<CR>', 'wrap'},
        },
        p = {
          name = 'plug',
        },
        q = {'<Cmd>q<CR>', 'quit'},
        r = {'<Cmd>redraw!<CR>', 'redraw!'},
        t = {
          name = 'toggle',
          f = {'<Cmd>FocusToggle<CR>', 'Focus'},
          g = {'<Cmd>Goyo<CR>', 'Goyo'},
          h = {'<Cmd>Hexmode<CR>', 'Hexmode'},
          l = {'<Cmd>Limelight!!<CR>', 'Limelight'},
          t = {'<Cmd>NvimTreeToggle<CR>', 'NvimTree'},
          u = {'<Cmd>UndotreeToggle<CR>', 'Undotree'},
        },
        w = {'<Cmd>w<CR>', 'write'},
        z = {'zz', 'zz'},
      }, {prefix = '<Leader>'})
    end,
  }
  use 'freitass/todo.txt-vim'
  use {
    'gelguy/wilder.nvim',
    config = function()
      vim.fn['wilder#setup'] {
        accept_key = '<Down>',
        modes = {':', '/', '?'},
        next_key = '<Tab>',
        previous_key = '<S-Tab>',
        reject_key = '<Up>',
      }
      vim.cmd [[call wilder#set_option('pipeline', [wilder#branch(wilder#python_file_finder_pipeline({ 'dir_command': ['find', '.', '-type', 'd', '-printf', '%P\n'], 'file_command': ['find', '.', '-type', 'f', '-printf', '%P\n'], 'filters': ['fuzzy_filter', 'difflib_sorter'] }), wilder#cmdline_pipeline({ 'fuzzy': 1, 'language': 'python' }), wilder#python_search_pipeline({ 'engine': 're', 'pattern': wilder#python_fuzzy_pattern(), 'sorter': wilder#python_difflib_sorter() }))])]]
      vim.cmd [[call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({ 'border': 'rounded', 'highlighter': wilder#basic_highlighter(), 'highlights': { 'border': 'Normal' }, 'left': [' ', wilder#popupmenu_devicons()], 'right': [' ', wilder#popupmenu_scrollbar()] })))]]
    end,
    run = ':UpdateRemotePlugins',
  }
  use {
    'hoob3rt/lualine.nvim',
    config = function ()
      require('plenary.reload').reload_module('lualine', true)
      require('lualine').setup {
        options = {theme = 'nord'},
      }
    end,
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
  }
  use 'junegunn/goyo.vim'
  use {
    'junegunn/limelight.vim',
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>pl', '<Plug>(Limelight)', {})
      vim.api.nvim_set_keymap('x', '<Leader>pl', '<Plug>(Limelight)', {})
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
    'justinmk/vim-sneak',
    config = function()
      vim.g['sneak#label'] = 1
      local nord4 = '#d8dee9'
      local nord11 = '#bf616a'
      vim.cmd('highlight Sneak guibg='..nord11..' guifg='..nord4)
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
  use {
    'lambdalisue/edita.vim',
    config = function()
      vim.g['edita#opener'] = 'split'
    end,
  }
  use 'lambdalisue/gina.vim'
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
        filetype_exclude = {
          'NvimTree',
          'gesture',
          'help',
          'packer',
          'startify',
          'translator',
        },
      }
    end,
  }
  use {
    'mattn/emmet-vim',
    config = function()
      vim.g.user_emmet_install_global = 0
      vim.cmd [[autocmd FileType html EmmetInstall]]
    end,
    ft = {'html'},
  }
  use {
    'mbbill/undotree',
    config = function()
      if vim.fn.has('persistent_undo') then
        local targetPath = vim.fn.expand('~/.undodir')
        if not vim.fn.isdirectory(targetPath) then
          vim.fn.mkdir(targetPath, 'p', tonumber('700', 8))
        end
        vim.o.undodir = targetPath
        vim.o.undofile = true
      end
      vim.g.undotree_HighlightChangedText = 0
      vim.g.undotree_WindowLayout = 3
    end,
  }
  use {
    'mhinz/vim-startify',
    config = function()
      vim.g.startify_change_to_dir = 0
      local version = vim.fn.system 'nvim -v | head -n1 | xargs echo -n'
      vim.g.startify_custom_header = vim.fn['startify#pad']({version})
    end,
  }
  use {
    'neoclide/coc.nvim',
    branch = 'release',
    requires = {
      {'neoclide/coc-lists', run = 'yarn install --flozen-lockfile'},
      {
        'neoclide/coc-snippets',
        config = function()
          vim.api.nvim_set_keymap('x', '<Leader>px', '<Plug>(coc-convert-snippet)', {})
          vim.api.nvim_set_keymap(
            'i',
            '<Tab>',
            [[pumvisible() ? coc#_select_confirm() : coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" : CheckBackSpace() ? "\<Tab>" : coc#refresh()]],
            {expr = true, silent = true}
          )
          vim.cmd [[
            function! CheckBackSpace() abort
              let col = col('.') - 1
              return !col || getline('.')[col - 1]  =~# '\s'
            endfunction
          ]]
          vim.g.coc_snippet_next = '<Tab>'
          vim.g.coc_snippet_prev = '<S-Tab>'
        end,
        requires = {'honza/vim-snippets'},
        run = 'yarn install --flozen-lockfile',
      },
      {
        'weirongxu/coc-calc',
        config = function()
          vim.api.nvim_set_keymap('n', '<Leader>pca', '<Plug>(coc-calc-result-append)', {})
          vim.api.nvim_set_keymap('n', '<Leader>pcr', '<Plug>(coc-calc-result-replace)', {})
        end,
        run = 'yarn install --flozen-lockfile',
      },
    },
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
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
          extended_mode = true,
          colors = {
            '#bf616a', -- nord11
            '#d08770', -- nord12
            '#ebcb8b', -- nord13
            '#a3be8c', -- nord14
            '#b48ead', -- nord15
          },
        },
      }
    end,
    requires = {
      'p00f/nvim-ts-rainbow',
    },
    run = ':TSUpdate',
  }
  use {
    'simeji/winresizer',
    config = function()
      vim.g.winresizer_start_key = '<Leader>pr'
    end,
  }
  use {
    't9md/vim-choosewin',
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>pc', '<Plug>(choosewin)', {})
      vim.g.choosewin_overlay_enable = 1
    end,
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
  use {
    'voldikss/vim-translator',
    config = function()
      vim.g.translator_target_lang = 'ja'
      vim.api.nvim_set_keymap('n', '<Leader>ptr', '<Plug>TranslateR', {silent = true})
      vim.api.nvim_set_keymap('n', '<Leader>ptt', '<Plug>Translate', {silent = true})
      vim.api.nvim_set_keymap('n', '<Leader>ptw', '<Plug>TranslateW', {silent = true})
      vim.api.nvim_set_keymap('n', '<Leader>ptx', '<Plug>TranslateX', {silent = true})
      vim.api.nvim_set_keymap('v', '<Leader>ptr', '<Plug>TranslateRV', {silent = true})
      vim.api.nvim_set_keymap('v', '<Leader>ptt', '<Plug>TranslateV', {silent = true})
      vim.api.nvim_set_keymap('v', '<Leader>ptw', '<Plug>TranslateWV', {silent = true})
    end,
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      local npairs = require('nvim-autopairs')
      _G.MUtils= {}
      MUtils.completion_confirm = function()
        if vim.fn.pumvisible() ~= 0  then
          return npairs.esc('<CR>')
        else
          return npairs.autopairs_cr()
        end
      end
      vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
      npairs.setup {}
    end,
  }
end)

-- vim: et sw=2
