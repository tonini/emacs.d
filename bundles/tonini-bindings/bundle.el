;; compiling
(cabbage-global-set-key (kbd "C-c c") 'mode-compile)
(cabbage-global-set-key (kbd "C-c k") 'mode-compile-kill)
;; ruby compilation
(cabbage-global-set-key (kbd "C-x M-r") 'ruby-compilation-this-buffer)

;; buffer handling
(cabbage-global-set-key (kbd "C-x M-k") 'kill-this-buffer)

;; ace jump mode
(cabbage-global-set-key (kbd "M-,") 'yas/expand)

;; dirtree
(cabbage-global-set-key (kbd "C-x t") 'dired-other-window)

;; Popwin
(cabbage-global-set-key (kbd "C-z") popwin:keymap)
