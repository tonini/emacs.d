;;; js-prt.el --- JavaScript setup

;;; Commentary:
;;

;;; Code:

(require 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'"    . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\.erb\\'"    . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(eval-after-load 'js2-mode
  '(progn
     (defun t-js-mode-defaults ()
       (setq js2-basic-offset 2)
       (local-unset-key (kbd "M-j")) ;; I use M-j for backward-char globaly
       (setq mode-name "JS2")
       (js2-imenu-extras-mode +1))

     (add-hook 'js2-mode-hook 't-js-mode-defaults)))

(provide 'js-prt)

;;; js-prt.el ends here
