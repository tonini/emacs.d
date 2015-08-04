(require 'smartparens)

(show-paren-mode t)
(smartparens-global-mode t)
(show-smartparens-global-mode nil)

;; Do not highlight paren area
(setq sp-highlight-pair-overlay nil)
(setq sp-highlight-wrap-overlay nil)
(setq sp-highlight-wrap-tag-overlay nil)
;; Do not use default slight delay
(setq show-paren-delay 0)

(provide 'smartparens-prt)
