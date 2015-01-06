;;; coffee-prt.el --- CoffeeScript setup

;;; Commentary:
;;

;;; Code:

(require 'coffee-mode)

(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.coffee\\.erb$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

(eval-after-load 'coffee-mode
  '(progn
     ;; CoffeeScript uses two spaces.
     (setq coffee-tab-width 2)

     (defun t-coffee-mode-default ()
       (subword-mode +1))

  (add-hook 'coffee-mode-hook 't-coffee-mode-defaults)))

(provide 'coffee-prt)

;;; coffee-prt.el ends here
