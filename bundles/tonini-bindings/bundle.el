(key-chord-mode 1)

(cabbage-global-set-key (kbd "C-c c") 'org-capture)
(cabbage-global-set-key (kbd "C-x M-r") 'ruby-compilation-this-buffer)
(cabbage-global-set-key (kbd "C-x M-k") 'kill-this-buffer)
(cabbage-global-set-key (kbd "C-x t") 'dired-other-window)
(cabbage-global-set-key (kbd "C-y") popwin:keymap)

;; Help

(defvar lisp-find-map)
(define-prefix-command 'lisp-find-map)

(cabbage-global-set-key (kbd "C-h e") 'lisp-find-map)

(cabbage-global-set-key (kbd "C-h e c") 'finder-commentary)
(cabbage-global-set-key (kbd "C-h e e") 'view-echo-area-messages)
(cabbage-global-set-key (kbd "C-h e f") 'find-function)
(cabbage-global-set-key (kbd "C-h e F") 'find-face-definition)
(cabbage-global-set-key (kbd "C-h e i") 'info-apropos)
(cabbage-global-set-key (kbd "C-h e k") 'find-function-on-key)
(cabbage-global-set-key (kbd "C-h e l") 'find-library)

;; Emacs Lisp

(defvar lisp-eval-map)
(define-prefix-command 'lisp-eval-map)

(cabbage-global-set-key (kbd "C-c e") 'lisp-eval-map)

(cabbage-global-set-key (kbd "C-c e b") 'eval-buffer)
(cabbage-global-set-key (kbd "C-c e r") 'eval-region)
(cabbage-global-set-key (kbd "C-c e l") 'eval-last-sexp)

;; Personal mapping

(key-chord-define-global "gg" 'magit-grep)
(key-chord-define-global "ff" 'tonini-fetch-snippet)
(key-chord-define-global "ee" 'tonini-run-ert-tests)
(key-chord-define-global "mt" 'tonini-make-test)

(cabbage-global-set-key (kbd "C-x p") 'tonini-project-ido-find-project)
(cabbage-global-set-key (kbd "C-_") 'cabbage-complete)
