-- Add root markers for ALL clients
vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.lsp.config['ocaml-language-server'] = {
  cmd = { 'ocamllsp' },
  filetypes = { 'ocaml' },
  root_markers = { '*.opam', 'dune-project', 'dune-workspace' },
  settings = {
    codelens = { enable = true },
    extendedHover = { enable = true },
    duneDiagnostics = { enable = true },
    inlayHints = {
      hintLetBindings = true,
      hintPatternVariables = true,
      hintFunctionParams = true,
    },
  },
}
vim.lsp.config['golang-language-server'] = {
  cmd = { 'gopls' },
  filetypes = { 'go' },
  root_markers = { 'go.mod' },
}

vim.lsp.enable("golang-language-server")
vim.lsp.enable("ocaml-language-server")

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true)
    end
    if client:supports_method('textDocument/documentHighlight') then
      vim.api.nvim_create_autocmd('CursorHold', {
        buffer = args.buf,
        callback = function() vim.lsp.buf.document_highlight() end,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        buffer = args.buf,
        callback = function() vim.lsp.buf.clear_references() end,
      })
    end
    if client:supports_method('textDocument/codeLens') then
      vim.lsp.codelens.refresh({ bufnr = args.buf })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave' }, {
        buffer = args.buf,
        callback = function()
          vim.lsp.codelens.refresh({ bufnr = args.buf })
        end,
      })
    end
    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
    end
    -- Auto-format on save.
    if client:supports_method('textDocument/formatting') then
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

vim.o.updatetime = 500

-- Add noselect to completeopt, otherwise autocompletion is annoying
vim.cmd("set completeopt+=noselect")

-- Enable rounded borders in floating windows
vim.o.winborder = 'rounded'

-- Enable virtual lines
vim.diagnostic.config({
  -- Use the default configuration
  virtual_lines = true,
})
