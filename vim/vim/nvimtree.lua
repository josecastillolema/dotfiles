local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  api.config.mappings.default_on_attach(bufnr)

  -- remove a default
  vim.keymap.del('n', '<C-t>', { buffer = bufnr })
  vim.keymap.del('n', '<C-x>', { buffer = bufnr })

  -- override a default
  --vim.keymap.set('n', '<C-x>', api.tree.close,                       opts('Close'))

  -- add your mappings
  --vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Close'))
end

require("nvim-tree").setup{
  on_attach = my_on_attach,
  disable_netrw = false,
  hijack_netrw = false,
}

-- Exit nvim if NvimTree is the only opened buffer
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      vim.cmd "quit"
    end
  end
})
