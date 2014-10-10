(require 'ido-vertical-mode)
(require 'flx-ido)

(defun tonini-load-setup-flx-ido ()
  (ido-mode 1)
  (ido-everywhere 1)
  (flx-ido-mode 1)
  ;; disable ido faces to see flx highlights.
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil))

(defun tonini-load-setup-ido-vertical-mode ()
  (ido-mode 1)
  (ido-vertical-mode 1))

(eval-after-load "ido-vertical-mode" '(tonini-load-setup-ido-vertical-mode))
(eval-after-load "flx-ido" '(tonini-load-setup-flx-ido))
