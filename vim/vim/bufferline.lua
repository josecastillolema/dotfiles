require("bufferline").setup{
  options = {
    always_show_bufferline = false,
    custom_filter = function(buf_number, buf_numbers)
      local bt = vim.bo[buf_number].buftype
      local ft = vim.bo[buf_number].filetype
      if bt == "terminal" then return false end
      if ft == "help" then return false end
      if ft == "qf" then return false end
      return true
    end,
    --highlights = {
    --  fill = {
    --fg = '<colour-value-here>',
    --    bg = '#2E3C43',
    --},
    --background = {
    --fg = '<colour-value-here>',
    --bg = '#2E3C43',
    --},
    --}
    middle_mouse_command = "bdelete! %d",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true
      }
    }
  }
}
