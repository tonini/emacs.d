;;; completion-prt.el --- completion setup

;;; Commentary:
;;

;;; Code:

(require 'company)

(eval-after-load "company"
  '(progn
     (setq company-idle-delay 0.3)
     (setq company-tooltip-limit 10)
     (setq company-minimum-prefix-length 2)
     (setq company-tooltip-flip-when-above t)

     (global-company-mode 1)

     ;; Keybindings
     (define-key company-active-map (kbd "M-k") 'company-select-next)
     (define-key company-active-map (kbd "M-i") 'company-select-previous)))

(provide 'completion-prt)

;;; completion-prt.el ends here
