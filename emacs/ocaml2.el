(use-package tuareg
  :ensure t
  :custom
  (tuareg-opam-insinuate t)
  :config)

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((tuareg-mode . lsp))
  :commands lsp
  :config
  (lsp-enable-which-key-integration t)
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection
                     '("opam" "exec" "--" "ocamllsp"))
    :major-modes '(caml-mode tuareg-mode reason-mode)
    :server-id 'ocamllsp)))
