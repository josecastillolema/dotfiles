(use-package eglot
  :init
  :commands eglot
  :hook  ((tuareg-mode . eglot))
  :after tuareg)

(use-package tuareg
  :ensure t
  :hook eglot
  :custom
  (tuareg-opam-insinuate t))

