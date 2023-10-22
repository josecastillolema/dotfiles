(windmove-default-keybindings 'control)

(add-hook 'tuareg-mode-hook #'(lambda ()
  (define-key tuareg-mode-map [backtab] 'completion-at-point)))
