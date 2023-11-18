require'lspconfig'.gopls.setup{
  on_attach = function()
     vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
     vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
     vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
     vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
     vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {buffer=0})
     vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer=0})
     vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})
  end,
}

require'lspconfig'.ocamllsp.setup{
  on_attach = function()
     vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
     vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
     vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
     vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {buffer=0})
     vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer=0})
     vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})
  end,
}

--vim.lsp.start({
--  name = 'ocaml',
--  cmd = {'ocamllsp'},
--  root_dir = vim.fs.dirname(vim.fs.find({'dune-project'}, { upward = true })[1]),
--})
