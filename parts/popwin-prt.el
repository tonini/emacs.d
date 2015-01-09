;;; popwin-prt.el --- Popwin setup

;;; Commentary:
;;

;;; Code:

(popwin-mode 1)

(defun popwin-bkr:update-window-reference ()
  (popwin:update-window-reference 'browse-kill-ring-original-window :safe t))

(add-hook 'popwin:after-popup-hook 'popwin-bkr:update-window-reference)

(push '(elixir-mix-task-runner) popwin:special-display-config)
(push '(dired-mode :position top :stick t) popwin:special-display-config)
(push "*Kill Ring*" popwin:special-display-config)
(push '(grep-mode :noselect t :stick t) popwin:special-display-config)
(push '("*Messages*" :noselect t :stick t) popwin:special-display-config)
(push '("*elixir help*" :height 25 :noselect t :stick t) popwin:special-display-config)
(push '("*compilation*" :noselect t :stick t) popwin:special-display-config)
(push '("*mix*" :height 25 :noselect t) popwin:special-display-config)
(push '("*alchemist message*" :height 20 :noselect t) popwin:special-display-config)
(push '("*overseer*" :noselect t :stick t) popwin:special-display-config)

(provide 'popwin-prt)

;;; popwin-prt.el ends here
