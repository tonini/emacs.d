(add-to-list 'load-path "~/Projects/overseer.el/")
(require 'overseer)

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
  (setq tab-width 2)
  (show-paren-mode +1)
  (turn-on-eldoc-mode)
  (rainbow-delimiters-mode +1)
  (rainbow-mode +1)
  (flycheck-mode +1)
  (setq mode-name "EL")
  (smartparens-mode +1)
  (tester-init-test-run #'overseer-test-file "test.el$")
  (tester-init-test-suite-run #'overseer-test))

;; disable checkdoc for emacs lisp, it's no annoying
(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(add-hook 'emacs-lisp-mode-hook  't-emacs-lisp-mode-hook)

(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'turn-on-elisp-slime-nav-mode))

(provide 'emacs-lisp-prt)
