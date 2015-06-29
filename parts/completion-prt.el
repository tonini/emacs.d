;;; completion-prt.el --- completion setup

;;; Commentary:
;;

;;; Code:

(require 'company)

(setq company-idle-delay 0.3)
(setq company-tooltip-limit 10)
(setq company-minimum-prefix-length 2)
(setq company-tooltip-flip-when-above t)

(global-company-mode 1)

(provide 'completion-prt)

;;; completion-prt.el ends here
