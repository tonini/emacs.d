(require 'helm-config)
(require 'helm-ag)
(require 'helm-projectile)

(define-key helm-command-map (kbd "o") 'helm-occur)
(define-key helm-command-map (kbd "g") 'helm-do-grep)
(define-key helm-command-map (kbd "SPC") 'helm-all-mark-rings)
(define-key helm-map (kbd "M-k") 'helm-next-line)
(define-key helm-map (kbd "M-i") 'helm-previous-line)
(define-key helm-find-files-map (kbd "M-k") 'helm-next-line)
(define-key helm-find-files-map (kbd "M-i") 'helm-previous-line)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal

(setq helm-split-window-in-side-p           t
      helm-buffers-fuzzy-matching           t
      helm-move-to-line-cycle-in-source     t
      helm-ff-search-library-in-sexp        t
      helm-ff-file-name-history-use-recentf t
      helm-ag-fuzzy-match                   t)

(substitute-key-definition 'find-tag 'helm-etags-select global-map)
(setq projectile-completion-system 'helm)
(helm-descbinds-mode)
(helm-mode 1)

;; Turn on helm-projectile key bindings
(helm-projectile-on)

;; Display helm buffers always at the bottom
;; Source: http://www.lunaryorn.com/2015/04/29/the-power-of-display-buffer-alist.html
(add-to-list 'display-buffer-alist
             `(,(rx bos "*helm" (* not-newline) "*" eos)
               (display-buffer-reuse-window display-buffer-in-side-window)
               (reusable-frames . visible)
               (side            . bottom)
               (window-height   . 0.4)))

(provide 'helm-prt)
