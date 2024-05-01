let g:neoformat_enabled_ocaml = ['ocamlformat']

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
