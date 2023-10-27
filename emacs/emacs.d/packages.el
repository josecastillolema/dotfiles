;; Initialize package sources
;;(require 'package)

;;(setq package-archives '(("melpa" . "https://melpa.org/packages/")
;;                         ("org" . "https://orgmode.org/elpa/")
;;                         ("elpa" . "https://elpa.gnu.org/packages/")))

;;(package-initialize)
;;(unless package-archive-contents
;;  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)
(setq use-package-verbose t)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper))
  :config
  (ivy-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)))
         ;; ("C-x b" . counsel-ibuffer)
         ;; ("C-x C-f" . counsel-find-file)
         ;;:map minibuffer-local-map
         ;;("C-r" . counsel-minibuffer-history)))

;;(use-package ivy-rich
;;  :init
;;  (ivy-rich-mode 1))

;;(require 'ido)
;;(ido-mode t)

;; (use-package helpful
;;   :custom
;;   (counsel-describe-function-function #'helpful-callable)
;;   (counsel-describe-variable-function #'helpful-variable)
;;   :bind
;;   ([remap describe-function] . counsel-describe-function)
;;   ([remap describe-command] . helpful-command)
;;   ([remap describe-variable] . counsel-describe-variable)
;;   ([remap describe-key] . helpful-key))

(use-package which-key
  :init (which-key-mode)
  ;;:diminish
  :config
  (setq which-key-idle-delay 5))

(use-package evil
  :init
  (setq evil-want-integration t)
  :config
  (evil-mode 1))

;; (use-package lsp-mode
;;   :init
;;   ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;;   (setq lsp-keymap-prefix "C-c l")
;;   :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;;          ;;(XXX-mode . lsp)
;;          ;; if you want which-key integration
;;          (lsp-mode . lsp-enable-which-key-integration))
;;   :commands lsp)
