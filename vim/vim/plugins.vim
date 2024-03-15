call plug#begin()
  Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
  Plug 'dstein64/nvim-scrollview'
  "Plug 'Exafunction/codeium.vim', { 'branch': 'main' }
  "Plug 'folke/neodev.nvim' " nvim lua API
  Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
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
  Plug 'ray-x/lsp_signature.nvim'
  Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
  Plug 'TamaMcGlinn/quickfixdd'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-sensible'
  Plug 'Vigemus/iron.nvim'
  Plug 'windwp/nvim-autopairs'
call plug#end()

lua << EOF
require('gitsigns').setup()
require("ibl").setup()
require("lsp_signature").setup()
require("nvim-autopairs").setup {}
EOF
