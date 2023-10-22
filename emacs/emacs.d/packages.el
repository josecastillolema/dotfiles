(require 'use-package)
(setq use-package-always-ensure t)

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

;(use-package ivy-rich
;  :init
;  (ivy-rich-mode 1))

;(require 'ido)
;(ido-mode t)

;;(use-package helpful
;;  :custom
;;  (counsel-describe-function-function #'helpful-callable)
;;  (counsel-describe-variable-function #'helpful-variable)
;;  :bind
;;  ([remap describe-function] . counsel-describe-function)
;;  ([remap describe-command] . helpful-command)
;;  ([remap describe-variable] . counsel-describe-variable)
;;  ([remap describe-key] . helpful-key))

(use-package which-key
  :init (which-key-mode)
  ;;:diminish
  :config
  (setq which-key-idle-delay 1))

(use-package evil
  :init
  (setq evil-want-integration t)
  :config
  (evil-mode 1))
