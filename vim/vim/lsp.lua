-- Add root markers for ALL clients
vim.lsp.config('*', {
  root_markers = { '.git' },
})

-- Configure the LSP server
--vim.lsp.config["lua-language-server"] = {
--  cmd = { "lua_ls" },
--  root_markers = { ".luarc.json" },
--  filetypes = { "lua" },
--}
vim.lsp.config['ocaml-language-server'] = {
  cmd = { 'ocamllsp' },
  filetypes = { 'ml' },
  root_markers = { '*.opam', 'dune-project', 'dune-workspace' },
}
vim.lsp.config['golang-language-server'] = {
  cmd = { 'gopls' },
  filetypes = { 'go' },
  root_markers = { 'go.mod' },
}

-- Enable the LSP server
--vim.lsp.enable("lua-language-server")
vim.lsp.enable("golang-language-server")
vim.lsp.enable("ocaml-language-server")

-- Set up an LspAttach autocommand to enable features based on client
-- capabilites. A single autocommand can work for multiple LSP servers!
--vim.api.nvim_create_autocmd('LspAttach' , {
--  callback = function(ev)
--    local client = vim.lsp.get_client_by_id(ev.data.client_id)
--    if client:support_method('textDocument/completion') then
--      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--    end
--  end,
--})
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation ...
    end
    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
    end
    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

-- Add noselect to completeopt, otherwise autocompletion is annoying
vim.cmd("set completeopt+=noselect")

-- Enable rounded borders in floating windows
vim.o.winborder = 'rounded'

-- Enable virtual lines
vim.diagnostic.config({
  -- Use the default configuration
  virtual_lines = true

  -- Alternatively, customize specific options
  -- virtual_lines = {
  --  -- Only show virtual line diagnostics for the current cursor line
  --  current_line = true,
  -- },
})
