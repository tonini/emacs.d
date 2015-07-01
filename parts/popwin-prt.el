;;; popwin-prt.el --- Popwin setup

;;; Commentary:
;;

;;; Code:

(popwin-mode 1)

(defun popwin-bkr:update-window-reference ()
  (popwin:update-window-reference 'browse-kill-ring-original-window :safe t))

(add-hook 'popwin:after-popup-hook 'popwin-bkr:update-window-reference)

(push '(dired-mode :position top :stick t :height 0.5) popwin:special-display-config)
(push "*Kill Ring*" popwin:special-display-config)
(push '(grep-mode :position right :width 0.5 :noselect t :stick t) popwin:special-display-config)
(push '("*Messages*" :noselect t :stick t) popwin:special-display-config)
(push '("*compilation*" :height 25 :noselect t :stick t) popwin:special-display-config)
(push '("*mix*" :height 0.5 :noselect t) popwin:special-display-config)
(push '("*alchemist message*" :height 20 :noselect t) popwin:special-display-config)
(push '("*overseer*" :height 35 :noselect t :stick nil) popwin:special-display-config)
(push '("*karma start*" :height 35 :noselect t :stick nil) popwin:special-display-config)

(provide 'popwin-prt)

;;; popwin-prt.el ends here
