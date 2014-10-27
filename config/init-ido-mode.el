(require 'ido-vertical-mode)
(require 'flx-ido)

(setq gc-cons-threshold 20000000)

(defun tonini-load-setup-flx-ido ()
  (ido-mode 1)
  (ido-everywhere 1)
  (flx-ido-mode 1)
  ;; disable ido faces to see flx highlights.
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil)

  (load (expand-file-name "~/.emacs.d/vendor/ido-hacks.el"))
  ;; (ido-hacks 1)

  (add-to-list 'ido-ignore-files "\\`node_modules/"))

(defun tonini-load-setup-ido-vertical-mode ()
  (ido-mode 1)
  (ido-vertical-mode 1)
  (setq ido-vertical-define-keys 'C-n-C-p-up-down))

(setq *textmate-gf-exclude*
  "(/|^)(\\.+[^/]+|public|node_modules|vendor|fixtures|tmp|log|classes|build)($|/)|(\\.xcodeproj|\\.nib|\\.framework|\\.app|\\.pbproj|\\.pbxproj|\\.xcode|\\.xcodeproj|\\.bundle|\\.pyc)(/|$)")

(eval-after-load "ido-vertical-mode" '(tonini-load-setup-ido-vertical-mode))
(eval-after-load "flx-ido" '(tonini-load-setup-flx-ido))

(provide 'init-ido-mode)
