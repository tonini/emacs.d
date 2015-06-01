;;; org-prt.el --- Org-Mode configurations

;;; Commentary:
;;

;;; Code:

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key "\M-a" 'smex)))

(provide 'org-prt)

;;; org-prt.el ends here
