require("telescope").setup {
  defaults = {
    sorting_strategy = "ascending",
  },
  extensions = {
    file_browser = {
      display_stat = false,
      hijack_netrw = true,
    },
  },
}
require("telescope").load_extension "file_browser"
