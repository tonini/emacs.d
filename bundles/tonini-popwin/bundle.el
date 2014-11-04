(require 'popwin)
(popwin-mode 1)

(defun popwin-bkr:update-window-reference ()
  (popwin:update-window-reference 'browse-kill-ring-original-window :safe t))

(add-hook 'popwin:after-popup-hook 'popwin-bkr:update-window-reference)

(push '(elixir-mix-task-runner) popwin:special-display-config)
(push '(dired-mode :position top) popwin:special-display-config)
(push "*Kill Ring*" popwin:special-display-config)
(push '(grep-mode :noselect t :stick t) popwin:special-display-config)
(push '("*compilation*" :noselect t :stick t) popwin:special-display-config)
