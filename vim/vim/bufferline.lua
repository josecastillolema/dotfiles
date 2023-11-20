require("bufferline").setup{
  options = {
    always_show_bufferline = false,
    middle_mouse_command = "bdelete! %d",
  },
  highlights = {
    fill = {
        --fg = '<colour-value-here>',
        bg = '#2E3C43',
    },
    --background = {
        --fg = '<colour-value-here>',
        --bg = '#2E3C43',
    --},
  }
}
