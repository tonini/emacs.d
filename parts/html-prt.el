(require 'web-mode)
(require 'smartparens)
(require 'smartparens-html)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq css-indent-offset 2)
;; make web-mode play nice with smartparens
(setq web-mode-enable-auto-pairing nil)

(setq web-mode-markup-indent-offset 2)

(sp-with-modes '(web-mode)
  (sp-local-pair "%" "%"
                 :unless '(sp-in-string-p)
                 :post-handlers '(((lambda (&rest _ignored)
                                     (just-one-space)
                                     (save-excursion (insert " ")))
                                   "SPC" "=" "#")))
  (sp-local-pair "<% "  " %>" :insert "C-c %")
  (sp-local-pair "<%= " " %>" :insert "C-c =")
  (sp-local-pair "<%# " " %>" :insert "C-c #")
  (sp-local-tag "%" "<% "  " %>")
  (sp-local-tag "=" "<%= " " %>")
  (sp-local-tag "#" "<%# " " %>"))

(defun t-haml-mode-hook ()
  (setq indent-tabs-mode nil)
  (setq comment-start "/ ")
  (define-key haml-mode-map (kbd "C-c C-k") 't-comment-or-uncomment-region-or-line))

(add-hook 'haml-mode-hook 't-haml-mode-hook)

(provide 'html-prt)
