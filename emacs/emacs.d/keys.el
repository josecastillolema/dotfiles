(windmove-default-keybindings 'control)

;; does not work
(define-key minibuffer-local-map (kbd "ESC") 'keyboard-escape-quit)

;;(keymap-global-set "C-z" 'keyboard-quit)
(global-set-key (kbd "C-z") 'keyboard-escape-quit)

;;(add-hook 'tuareg-mode-hook #'(lambda ()
;;  (define-key tuareg-mode-map [backtab] 'completion-at-point)))
