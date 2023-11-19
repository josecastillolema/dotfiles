-- Seem to be ignored
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
vim.api.nvim_create_user_command("Explore", "Telescope file_browser path=%:p:h", {})
