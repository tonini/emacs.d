(require 'smart-mode-line)

(defun tonini-init-smart-mode-line ()
  (sml/setup)
  (sml/apply-theme 'automatic))

(eval-after-load "smart-mode-line" '(tonini-init-smart-mode-line))

(provide 'init-smart-mode-line)
