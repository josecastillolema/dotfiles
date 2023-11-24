require("bufferline").setup{
  options = {
    always_show_bufferline = false,
    custom_filter = function(buf_number, buf_numbers)
      -- dont show help buffers in the bufferline
      if vim.bo[buf_number].filetype ~= "help" then
        return true
      end
      -- dont show quickfix buffers in the bufferline
      -- Not working, see https://github.com/akinsho/bufferline.nvim/issues/176
      -- Used autocmd instead
      if vim.bo[buf_number].filetype ~= "qf" then
        return true
      end
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
