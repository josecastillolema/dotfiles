local actions = require "telescope.actions"

require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<C-x>"] = actions.close,
      }
    },
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
