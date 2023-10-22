;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

(setq inhibit-startup-message t)
(setq confirm-kill-emacs nil)
(setq vc-follow-symlinks nil)

;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
  (setq backup-directory-alist
    `((".*" . ,emacs-tmp-dir)))
  (setq auto-save-file-name-transforms
    `((".*" ,emacs-tmp-dir t)))
  (setq auto-save-list-file-prefix
    emacs-tmp-dir)
