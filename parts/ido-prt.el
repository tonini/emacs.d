(require 'ido)
(require 'flx-ido)

(setq gc-cons-threshold 20000000)

(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(ido-vertical-mode 1)

(setq ido-vertical-define-keys 'C-n-C-p-up-down)
(setq ido-vertical-show-count nil)
(setq ido-auto-merge-work-directories-length -1)

;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)
(setq ido-enable-flex-matching t)

(smex-initialize)
(ido-ubiquitous t)

(add-to-list 'ido-ignore-files "\\`node_modules/")
(add-to-list 'ido-ignore-files "\\.DS_Store/")

(setq *textmate-gf-exclude* "(/|^)(\\.+[^/]+|public|node_modules|vendor|fixtures|tmp|log|classes|build)($|/)|(\\.xcodeproj|\\.nib|\\.framework|\\.app|\\.pbproj|\\.pbxproj|\\.xcode|\\.xcodeproj|\\.bundle|\\.pyc)(/|$)")

;; Keybindings
(defun ido-my-keys ()
  (define-key ido-completion-map (kbd "M-k") 'ido-next-match)
  (define-key ido-completion-map (kbd "M-i") 'ido-prev-match))

(add-hook 'ido-setup-hook 'ido-my-keys)

(provide 'ido-prt)
