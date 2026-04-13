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
  settings = {
    gopls = {
      codelenses = {
        test = true,
        run_govulncheck = true,
        generate = true,
        gc_details = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}

vim.lsp.config['ty'] = {
  cmd = { 'ty', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile' },
}

vim.lsp.enable("ty")
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
      vim.lsp.codelens.enable(true, { bufnr = args.buf })
      vim.keymap.set('n', 'grl', vim.lsp.codelens.run, { buffer = args.buf, desc = 'CodeLens run' })
    end
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { buffer = args.buf, desc = 'Rename' })
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = args.buf, desc = 'Code action' })
    vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format({ timeout_ms = 1000 }) end, { buffer = args.buf, desc = 'Format' })
    vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, { buffer = args.buf, desc = 'Go to definition' })
    vim.keymap.set('n', '<leader>ls', vim.lsp.buf.references, { buffer = args.buf, desc = 'References' })
    vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, { buffer = args.buf, desc = 'Hover' })
    vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, { buffer = args.buf, desc = 'Implementation' })
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

-- Diagnostic signs
local signs = {
  [vim.diagnostic.severity.ERROR] = '\u{f0159}',
  [vim.diagnostic.severity.WARN]  = '\u{f0026}',
  [vim.diagnostic.severity.INFO]  = '\u{f02fc}',
  [vim.diagnostic.severity.HINT]  = '\u{f0335}',
}

-- Enable virtual lines and custom signs
vim.diagnostic.config({
  virtual_lines = true,
  signs = { text = signs },
})
