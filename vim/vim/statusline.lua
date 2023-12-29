require('lualine').setup {
  -- disabled_filetypes = {'NvimTree'}, -- Not working
  extensions = {'nvim-tree', 'quickfix'},
  options = {
    theme = 'material',
  },
  sections = {
    lualine_y = {'filetype'},
    lualine_x = { 'codeium#GetStatusString' },
  },
}
