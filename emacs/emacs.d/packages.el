(require 'use-package)
(setq use-package-always-ensure t)

(use-package ivy
  :config
  ;;:diminish "ivy-mode"
  (ivy-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)))
         ;; ("C-x b" . counsel-ibuffer)
         ;; ("C-x C-f" . counsel-find-file)
         ;;:map minibuffer-local-map
         ;;("C-r" . counsel-minibuffer-history)))

;(use-package ivy-rich
;  :init
;  (ivy-rich-mode 1))

;(require 'ido)
;(ido-mode t)

(use-package which-key
  :init (which-key-mode)
  ;;:diminish 'which-key-mode
  :config
  (setq which-key-idle-delay 1))
