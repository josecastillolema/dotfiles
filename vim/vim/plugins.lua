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
  "https://github.com/folke/which-key.nvim",
  "https://github.com/gelguy/wilder.nvim",
})

require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = require('gitsigns')
    local opts = function(desc) return { buffer = bufnr, desc = desc } end
    vim.keymap.set('n', '<leader>gs', gs.stage_hunk, opts('Stage hunk'))
    vim.keymap.set('n', '<leader>gr', gs.reset_hunk, opts('Reset hunk'))
    vim.keymap.set('v', '<leader>gs', function() gs.stage_hunk({vim.fn.line('.'), vim.fn.line('v')}) end, opts('Stage hunk'))
    vim.keymap.set('v', '<leader>gr', function() gs.reset_hunk({vim.fn.line('.'), vim.fn.line('v')}) end, opts('Reset hunk'))
    vim.keymap.set('n', '<leader>gu', gs.undo_stage_hunk, opts('Undo stage hunk'))
    vim.keymap.set('n', '<leader>gp', gs.preview_hunk, opts('Preview hunk'))
    vim.keymap.set('n', '<leader>gb', gs.blame_line, opts('Blame line'))
    vim.keymap.set('n', '<leader>gd', gs.diffthis, opts('Diff'))
    vim.keymap.set('n', '<leader>gn', gs.next_hunk, opts('Next hunk'))
    vim.keymap.set('n', '<leader>gN', gs.prev_hunk, opts('Prev hunk'))
  end,
})
require("ibl").setup()
require("nvim-autopairs").setup {}
require("which-key").setup()

local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })
wilder.set_option("renderer", wilder.popupmenu_renderer(
  wilder.popupmenu_palette_theme({
    border = 'rounded',
    max_height = '75%',
    min_height = 0,
    prompt_position = 'top',
    reverse = 0,
    highlighter = wilder.basic_highlighter(),
    left = { " ", wilder.popupmenu_devicons() },
    right = { " ", wilder.popupmenu_scrollbar() },
  })
))
wilder.set_option("pipeline", {
  wilder.branch(
    wilder.cmdline_pipeline({
      language = 'vim',
      fuzzy = 1,
      fuzzy_filter = wilder.vim_fuzzy_filter(),
    }),
    wilder.vim_search_pipeline()
  ),
})
