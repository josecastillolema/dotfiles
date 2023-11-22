require('lualine').setup {
  -- disabled_filetypes = {'NvimTree'}, -- Not working
  extensions = {'nvim-tree', 'quickfix'},
  options = {
    theme = 'material',
  },
  sections = {
    lualine_x = {'filetype'},
  },
}
