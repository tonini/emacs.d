(setq gc-cons-threshold 20000000)

(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-C-p-up-down)

;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(smex-initialize)
(ido-ubiquitous t)

(add-to-list 'ido-ignore-files "\\`node_modules/")

(setq *textmate-gf-exclude* "(/|^)(\\.+[^/]+|public|node_modules|vendor|fixtures|tmp|log|classes|build)($|/)|(\\.xcodeproj|\\.nib|\\.framework|\\.app|\\.pbproj|\\.pbxproj|\\.xcode|\\.xcodeproj|\\.bundle|\\.pyc)(/|$)")

(provide 'ido-prt)
