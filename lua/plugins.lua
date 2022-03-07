vim.cmd[[packadd packer.nvim]]

require'packer'.startup(function()
  use{'wbthomason/packer.nvim', opt = true}

  use{'marko-cerovac/material.nvim'}
  use{'lambdalisue/fern.vim'}
  use{'mattn/vim-goimports'}
  use{'airblade/vim-gitgutter'}

  use{'rhysd/git-messenger.vim', opt = true, cmd = {'GitMessenger'}}

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use { 'neovim/nvim-lspconfig',  -- Collection of configurations for the built-in LSP client
        'williamboman/nvim-lsp-installer' }

  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/vim-vsnip"

  use { "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } }

end)
