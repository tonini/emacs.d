;; compiling
(cabbage-global-set-key (kbd "C-c c") 'mode-compile)
(cabbage-global-set-key (kbd "C-c k") 'mode-compile-kill)
;; ruby compilation
(cabbage-global-set-key (kbd "C-x M-r") 'ruby-compilation-this-buffer)

;; org-mode
(cabbage-global-set-key (kbd "C-c t") 'tonini-org-new-project-todo)

;; buffer navigation
(cabbage-global-set-key (kbd "C-ä") 'forward-buffer)
(cabbage-global-set-key (kbd "C-ö") 'backward-buffer)

;; buffer handling
(cabbage-global-set-key (kbd "C-x M-k") 'kill-this-buffer)

;; ace jump mode
(cabbage-global-set-key (kbd "M-,") 'yas/expand)

;; dirtree
(cabbage-global-set-key (kbd "C-x t") 'dired-other-window)

;; Popwin
(cabbage-global-set-key (kbd "C-z") popwin:keymap)

;; Find file
;; (cabbage-global-set-key (kbd "M-t") 'find-file-in-project)
