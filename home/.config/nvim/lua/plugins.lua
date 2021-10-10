local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

function inTermux()
  return vim.fn.executable('termux-setup-storage') == 1
end

function previmConfig()
  -- ref: https://milligram.io/#getting-started
  vim.g.previm_custom_css_paths = {
    'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.2.0/styles/stackoverflow-light.min.css',
    'https://fonts.googleapis.com/css?family=Roboto:300,300italic,700,700italic',
    'https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.css',
    'https://cdnjs.cloudflare.com/ajax/libs/milligram/1.4.1/milligram.css',
    '~/.config/nvim/previm-custom.css',
  }

  vim.g.previm_disable_default_css = 1
  if inTermux() then
    vim.g.previm_open_cmd = 'am start --activity-clear-task com.android.chrome/org.chromium.chrome.browser.ChromeTabbedActivity -d'
  else
    vim.g.previm_open_cmd = 'xdg-open'
  end
  vim.g.previm_show_header = 0
end

local packer = require 'packer'

return packer.startup({function(use)
  use 'wbthomason/packer.nvim'
  use {
    'MunifTanjim/nui.nvim',
    config = function()
      function webSearch()
        local Input = require("nui.input")
        local event = require("nui.utils.autocmd").event

        local input = Input({
          position = 0,
          size = {
              width = 20,
              height = 2,
          },
          relative = "cursor",
          border = {
            highlight = "MyHighlightGroup",
            style = "single",
            text = {
                top = "WebSearch",
                top_align = "center",
            },
          },
          win_options = {
            winblend = 10,
            winhighlight = "Normal:Normal",
          },
        }, {
          prompt = "> ",
          default_value = "",
          on_close = function()
            print("Input closed!")
          end,
          on_submit = function(value)
            vim.fn.system {'xdg-open', 'https://duckduckgo.com/?q=' .. value}
          end,
        })

        -- mount/open the component
        input:mount()

        -- unmount component when cursor leaves buffer
        input:on(event.BufLeave, function()
          input:unmount()
        end)
      end

      vim.cmd [[command! WebSearch lua webSearch()]]

      vim.api.nvim_set_keymap('n', '<Leader>cw', '<Cmd>WebSearch<CR>', {noremap = true, silent = true})
    end,
  }
  use {
    'Pocco81/AutoSave.nvim',
    config = function()
      require('autosave').setup {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
          exists = true,
          filename_is_not = {'init_user.lua', 'plugins.lua'},
          filetype_is_not = {},
          modifiable = true,
        },
        write_all_buffers = false,
        on_off_commands = false,
        clean_command_line_interval = 0,
        debounce_delay = 135
      }
    end,
  }
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
  use 'embear/vim-localvimrc'
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
        T = {
          name = 'tab',
          c = {'<Cmd>tabnew<CR>', 'new'},
          n = {'<Cmd>tabnext<CR>', 'next'},
          p = {'<Cmd>tabprevious<CR>', 'previous'},
        },
        W = {'<Cmd>wq<CR>', 'wq'},
        [' '] = {
          name = 'Telescope',
          F = {'<Cmd>Telescope file_browser<CR>', 'file_browser'},
          G = {'<Cmd>Telescope grep_string<CR>', 'grep_string'},
          T = {'<Cmd>TodoTelescope<CR>', 'todo'},
          [' '] = {'<Cmd>Telescope<CR>', 'Telescope'},
          b = {'<Cmd>Telescope buffers<CR>', 'buffers'},
          c = {'<Cmd>Telescope command_history<CR>', 'command_history'},
          f = {'<Cmd>Telescope find_files<CR>', 'find_files'},
          g = {
            name = 'git',
            C = {'<Cmd>Telescope git_bcommits<CR>', 'bcommits'},
            b = {'<Cmd>Telescope git_branches<CR>', 'branches'},
            c = {'<Cmd>Telescope git_commits<CR>', 'commits'},
            f = {'<Cmd>Telescope git_files<CR>', 'files'},
            h = {'<Cmd>Telescope git_stash<CR>', 'stash'},
            s = {'<Cmd>Telescope git_status<CR>', 'status'},
          },
          l = {'<Cmd>Telescope live_grep<CR>', 'live_grep'},
          m = {'<Cmd>Telescope coc mru<CR>', 'mru'},
          r = {'<Cmd>Telescope registers<CR>', 'registers'},
          s = {'<Cmd>Telescope search_history<CR>', 'search_history'},
          t = {'<Cmd>Telescope treesitter<CR>', 'treesitter'},
        },
        [','] = {
          name = 'config',
          l = {'<Cmd>FocusSplitNicely ~/.config/nvim/lua/init_local.lua<CR>', 'local'},
          p = {'<Cmd>FocusSplitNicely ~/.config/nvim/lua/plugins.lua<CR>', 'plugins'},
          u = {'<Cmd>FocusSplitNicely ~/.config/nvim/lua/init_user.lua<CR>', 'user'},
        },
        [';'] = {
          name = 'window',
          H = {'<Cmd>FocusSplitLeft<CR>', 'FocusSplitLeft'},
          J = {'<Cmd>FocusSplitDown<CR>', 'FocusSplitDown'},
          K = {'<Cmd>FocusSplitUp<CR>', 'FocusSplitUp'},
          L = {'<Cmd>FocusSplitRight<CR>', 'FocusSplitRight'},
          [';'] = {'<Cmd>FocusSplitNicely<CR>', 'FocusSplitNicely'},
          c = {'<Cmd>FocusSplitCycle<CR>', 'FocusSplitCycle'},
          e = {'<Cmd>FocusEqualise<CR>', 'FocusEqualise'},
          h = {'<C-w>h', '<C-w>h'},
          j = {'<C-w>j', '<C-w>j'},
          k = {'<C-w>k', '<C-w>k'},
          l = {'<C-w>l', '<C-w>l'},
          n = {'<C-w>w', '<C-w>w'},
          p = {'<C-w>W', '<C-w>W'},
          q = {'<C-w>q', '<C-w>q'},
          s = {'<C-w>s', '<C-w>s'},
          v = {'<C-w>v', '<C-w>v'},
          z = {'<Cmd>FocusMaximise<CR>', 'FocusMaximise'},
        },
        a = {
          name = 'asynctasks.vim',
          b = {'<Cmd>let g:floaterm_position_orig = g:floaterm_position | let g:floaterm_position = "bottomright" | execute "AsyncTask file-build" | let g:floaterm_position = g:floaterm_position_orig<CR>', 'file-build'},
          e = {'<Cmd>let g:floaterm_wintype_orig = g:floaterm_wintype | let g:floaterm_wintype = "split" | execute "AsyncTask repl" | let g:floaterm_wintype = g:floaterm_wintype_orig<CR>', 'repl'},
          r = {'<Cmd>let g:floaterm_height_orig = g:floaterm_height | let g:floaterm_width_orig = g:floaterm_width | let g:floaterm_height = 0.9 | let g:floaterm_width = 0.9 | execute "AsyncTask file-run" | let g:floaterm_height = g:floaterm_height_orig | let g:floaterm_width = g:floaterm_width_orig<CR>', 'file-run'},
          t = {'<Cmd>let g:floaterm_position_orig = g:floaterm_position | let g:floaterm_position = "bottomright" | execute "AsyncTask test" | let g:floaterm_position = g:floaterm_position_orig<CR>', 'test'},
        },
        c = {
          name = 'cmd',
          E = {'<Cmd>EvalBlock!<CR>', 'EvalBlock!'},
          S = {'<Cmd>%FloatermSend<CR>', 'FloatermSend'},
          a = {'<Cmd>sort<CR>', 'sort'},
          c = {'<Cmd>Calendar<CR>', 'Calendar'},
          e = {'<Cmd>EvalBlock<CR>', 'EvalBlock'},
          p = {
            name = 'previm',
            o = {'<Cmd>PrevimOpen<CR>', 'open'},
            r = {'<Cmd>PrevimRefresh<CR>', 'refresh'},
            w = {'<Cmd>PrevimWipeCache<CR>', 'wipe cache'},
          },
          s = {'<Cmd>FloatermSend<CR>', 'FloatermSend'},
          t = {'<Cmd>TortoiseTyping<CR>', 'TortoiseTyping'},
          z = {'<Cmd>sort!<CR>', 'sort!'},
        },
        e = {'<Cmd>e!<CR>', 'edit!'},
        f = {
          name = 'focus',
          t = {'<Cmd>NvimTreeFocus<CR>', 'NvimTree'},
        },
        g = {
          name = 'git',
          C = {'<Cmd>Gina --opener=vsplit commit --amend<CR>', 'commit --amend'},
          L = {'<Cmd>FloatermNew --autoclose=1 --height=0.9 --width=0.9 git log -10 -p<CR>', 'log -10 -p'},
          P = {'<Cmd>FloatermNew --autoclose=1 git pull<CR>', 'pull'},
          R = {'<Cmd>vsplit | terminal git rebase --continue<CR>', 'rebase --continue'},
          S = {'<Cmd>Gina --opener=vsplit status -s<CR>', 'Gina status'},
          a = {'<Cmd>FloatermNew --height=0.9 --width=0.9 git add -p<CR>', 'add -p'},
          c = {'<Cmd>Gina --opener=vsplit commit<CR>', 'commit'},
          h = {
            name = 'stash',
            c = {'<Cmd>FloatermNew git stash clear<CR>', 'clear'},
            h = {'<Cmd>FloatermNew git stash<CR>', '(no args)'},
            l = {'<Cmd>FloatermNew git stash list<CR>', 'list'},
            p = {'<Cmd>FloatermNew git stash pop stash@{0}<CR>', 'pop stash@{0}'},
          },
          l = {'<Cmd>Gina --opener=vsplit log --graph<CR>', 'log'},
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
          L = {'<Cmd>lua toggleTranslatorLang()<CR>', 'TranslatorLang'},
          T = {'<Cmd>TransparentToggle<CR>', 'Transparent'},
          a = {'<Cmd>ASToggle<CR>', 'AutoSave'},
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
    'glts/vim-radical',
    requires = {
      'glts/vim-magnum',
      'tpope/vim-repeat',
    },
  }
  use {
    'gpanders/vim-medieval',
    config = function()
      vim.g.medieval_langs = {'bash', 'c=file-run-c', 'javascript=node', 'python', 'sh'}
    end,
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
  use 'itchyny/calendar.vim'
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
    'junegunn/vim-easy-align',
    config = function()
      vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})
      vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})
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
    config = function() require('nvim-tree').setup {} end,
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
        highlight IndentBlanklineIndent5 guifg=#8fbcbb blend=nocombine " nord7
        highlight IndentBlanklineIndent6 guifg=#88c0d0 blend=nocombine " nord8
        highlight IndentBlanklineIndent7 guifg=#81a1c1 blend=nocombine " nord9
        highlight IndentBlanklineIndent8 guifg=#5f81ac blend=nocombine " nord10
        highlight IndentBlanklineIndent9 guifg=#b48ead blend=nocombine " nord15
      ]]
      require('indent_blankline').setup {
        char_highlight_list = {
          'IndentBlanklineIndent1',
          'IndentBlanklineIndent2',
          'IndentBlanklineIndent3',
          'IndentBlanklineIndent4',
          'IndentBlanklineIndent5',
          'IndentBlanklineIndent6',
          'IndentBlanklineIndent7',
          'IndentBlanklineIndent8',
          'IndentBlanklineIndent9',
        },
        filetype_exclude = {
          'NvimTree',
          'calendar',
          'floaterm',
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
    'mg979/vim-visual-multi',
    branch = 'master',
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
            {expr = true, noremap = true, silent = true}
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
      require('colorizer').setup({
        '*';
        css = { rgb_fn = true; };
      })
    end,
  }
  use {
    'notomo/gesture.nvim',
    config = function()
      vim.api.nvim_set_keymap('n', '<RightMouse>', '<Nop>', {noremap = true})
      vim.api.nvim_set_keymap('n', '<RightDrag>', '<Cmd>lua require("gesture").draw()<CR>', {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<RightRelease>', '<Cmd>lua require("gesture").finish()<CR>', {noremap = true, silent = true})
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
            '#8fbcbb', -- nord7
            '#88c0d0', -- nord8
            '#81a1c1', -- nord9
            '#5f81ac', -- nord10
            '#b48ead', -- nord15
          },
          termcolors = {
            '1',  -- nord11
            '11', -- nord12
            '3',  -- nord13
            '2',  -- nord14
            '14', -- nord7
            '6',  -- nord8
            '4',  -- nord9
            '12', -- nord10
            '5',  -- nord15
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
    'plasticboy/vim-markdown',
    requires = 'godlygeek/tabular',
  }
  use {
    'sakkke/previm', -- previm/previm
    branch = 'latest',
    config = previmConfig,
    disable = inTermux(),
  }
  use {
    '/sdcard/previm',
    as = 'previm-in-termux',
    config = previmConfig,
    disable = not (inTermux() and vim.fn.isdirectory('/sdcard/previm')),
  }
  use {
    'simeji/winresizer',
    config = function()
      vim.g.winresizer_start_key = '<Leader>pr'
    end,
  }
  use {
    'skywind3000/asynctasks.vim',
    config = function()
      vim.g.asynctasks_extra_config = {'~/.config/nvim/tasks.ini', '~/.config/nvim/tasks_local.ini'}
      vim.g.asynctasks_term_pos = 'floaterm'
    end,
    requires = {
      {
        'skywind3000/asyncrun.vim',
        config = function()
          vim.g.asyncrun_rootmarks = {'.git', '.svn', '.root', '.project', '.hg'}
        end,
        requires = 'skywind3000/asyncrun.extra',
      },
    },
  }
  use {
    't9md/vim-choosewin',
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>pq', '<Plug>(choosewin)', {})
      vim.g.choosewin_overlay_enable = 1
    end,
  }
  use 'thanthese/Tortoise-Typing'
  use 'tpope/vim-sleuth'
  use {
    'tpope/vim-surround',
    config = function()
      vim.g.surround_61 = '==\r=='
    end,
    requires = 'tpope/vim-repeat',
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
      vim.api.nvim_set_keymap('x', '<Leader>cs', ':FloatermSend<CR>', {noremap = true, silent = true})
    end,
  }
  use {
    'voldikss/vim-translator',
    config = function()
      vim.g.translator_source_lang = 'en'
      vim.g.translator_target_lang = 'ja'
      vim.api.nvim_set_keymap('n', '<Leader>ptr', '<Plug>TranslateR', {silent = true})
      vim.api.nvim_set_keymap('n', '<Leader>ptt', '<Plug>Translate', {silent = true})
      vim.api.nvim_set_keymap('n', '<Leader>ptw', '<Plug>TranslateW', {silent = true})
      vim.api.nvim_set_keymap('n', '<Leader>ptx', '<Plug>TranslateX', {silent = true})
      vim.api.nvim_set_keymap('v', '<Leader>ptr', '<Plug>TranslateRV', {silent = true})
      vim.api.nvim_set_keymap('v', '<Leader>ptt', '<Plug>TranslateV', {silent = true})
      vim.api.nvim_set_keymap('v', '<Leader>ptw', '<Plug>TranslateWV', {silent = true})
      function toggleTranslatorLang()
        vim.g.translator_source_lang, vim.g.translator_target_lang = vim.g.translator_target_lang, vim.g.translator_source_lang
      end
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

  if packer_bootstrap then
    packer.sync()
  end
end, config = {
  display = {
    open_fn = function()
      return require('packer.util').float({border = 'single'})
    end,
  }
}})

-- vim: et sw=2
