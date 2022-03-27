local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'
  use({
    "sakkke/catppuccin-nvim",
    as = "catppuccin"
  })
  use {
    'feline-nvim/feline.nvim',
    config = function()
      require('feline').setup {
        components = require 'catppuccin.core.integrations.feline'
      }
    end,
    requires = {
      'kyazdani42/nvim-web-devicons',
      {
        'lewis6991/gitsigns.nvim',
        config = function()
          require('gitsigns').setup()
        end
      },
    },
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
