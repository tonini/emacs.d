;;; emacs-lisp-prt.el --- Elixir setup

;;; Commentary:
;; 

;;; Code:

(add-to-list 'auto-mode-alist '("Cask" . emacs-lisp-mode))

;; add additional files / directories to execlude from textmate-goto-file
(when (not (string-match "backup" *textmate-gf-exclude*))
  (setq *textmate-gf-exclude*
        (replace-regexp-in-string "tmp"
                                  "tmp|backup|elpa|\.cask"
                                  *textmate-gf-exclude*))
  (setq *textmate-project-roots*
        (append *textmate-project-roots* '("Cask" ".cask"))))

(defun t-emacs-lisp-mode-hook ()
  (turn-on-eldoc-mode)
  (rainbow-delimiters-mode +1)
  (rainbow-mode +1)
  (flycheck-mode +1)
  (setq mode-name "EL"))

(add-hook 'emacs-lisp-mode-hook  't-emacs-lisp-mode-hook)

(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'turn-on-elisp-slime-nav-mode))

(provide 'emacs-lisp-prt)

;;; emacs-lisp-prt.el ends here
