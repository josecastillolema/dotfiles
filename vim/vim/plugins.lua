vim.pack.add({
  "https://github.com/akinsho/bufferline.nvim",
  "https://github.com/dstein64/nvim-scrollview",
  "https://github.com/joshdick/onedark.vim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/lukas-reineke/indent-blankline.nvim",
  "https://github.com/kyazdani42/nvim-tree.lua",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-telescope/telescope-file-browser.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/TamaMcGlinn/quickfixdd",
  "https://github.com/Vigemus/iron.nvim",
  "https://github.com/windwp/nvim-autopairs",
})

require('gitsigns').setup()
require("ibl").setup()
require("nvim-autopairs").setup {}
