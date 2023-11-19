call plug#begin()
  "Plug 'folke/neodev.nvim' " nvim lua API
  Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
  Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
  Plug 'L3MON4D3/LuaSnip' " Snippets plugin
  Plug 'neovim/nvim-lspconfig' " Collection of configurations for built-in LSP client
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
  Plug 'nvim-telescope/telescope-file-browser.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
  Plug 'tpope/vim-sensible'
  Plug 'Vigemus/iron.nvim'
call plug#end()
