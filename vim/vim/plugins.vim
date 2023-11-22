call plug#begin()
  Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
  "Plug 'folke/neodev.nvim' " nvim lua API
  Plug 'dstein64/nvim-scrollview'
  Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
  Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
  Plug 'joshdick/onedark.vim'
  Plug 'L3MON4D3/LuaSnip' " Snippets plugin
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'neovim/nvim-lspconfig' " Collection of configurations for built-in LSP client
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
  Plug 'nvim-telescope/telescope-file-browser.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  "Plug 'petertriho/nvim-scrollbar' " Not grabbable
  Plug 'preservim/nerdcommenter'
  Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
  Plug 'tpope/vim-sensible'
  Plug 'Vigemus/iron.nvim'
call plug#end()

lua << EOF
require('gitsigns').setup()
require("ibl").setup()
EOF
