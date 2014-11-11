(cabbage-global-set-key (kbd "C-c c") 'mode-compile)
(cabbage-global-set-key (kbd "C-c k") 'mode-compile-kill)
(cabbage-global-set-key (kbd "C-x M-r") 'ruby-compilation-this-buffer)
(cabbage-global-set-key (kbd "C-x M-k") 'kill-this-buffer)
(cabbage-global-set-key (kbd "C-x t") 'dired-other-window)
(cabbage-global-set-key (kbd "C-z") popwin:keymap)

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
