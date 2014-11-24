(cabbage-vendor 'textmate)

;; add additional files / directories to execlude from textmate-goto-file
(when (not (string-match "backup" *textmate-gf-exclude*))
  (setq *textmate-gf-exclude*
        (replace-regexp-in-string "tmp"
                                  "tmp|backup|elpa|\.cask"
                                  *textmate-gf-exclude*))
  (setq *textmate-project-roots*
        (append *textmate-project-roots* '("Cask" ".cask"))))


(push "Cask" cabbage-project-root-indicators)
(push ".cask" cabbage-project-root-indicators)

(defun tonini-make-test ()
  (interactive)
  (let ((old-directory default-directory)
        (default-directory (cabbage-project-root)))
    (compile "make test")
    (cd old-directory)))

(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'turn-on-elisp-slime-nav-mode))
