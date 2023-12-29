--require("scrollbar").setup({
--  handle = {
--    color = "#808080",
--  },
--  show_in_active_only = true,
--})

--does not work https://www.reddit.com/r/neovim/comments/px8j89/highlight_command_in_initlua/
--vim.cmd('highlight ScrollView guibg=#808080')
require('scrollview').setup({
  excluded_filetypes = {'NvimTree'},
  current_only = true,
})

