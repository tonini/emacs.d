(add-to-list 'cabbage-bundle-dirs (expand-file-name "~/.emacs.d/bundles/"))
(add-to-list 'cabbage-vendor-dirs (expand-file-name "~/.emacs.d/vendor/"))
(add-to-list 'cabbage-bundle-dirs (expand-file-name "~/Projects/cabbage-contrib/bundles/"))
(add-to-list 'cabbage-vendor-dirs (expand-file-name "~/Projects/cabbage-contrib/vendor/"))

(setq tonini-vendor-dir
      (expand-file-name "~/.emacs.d/vendor/"))

(defun tonini-pre-bundle-hook ()
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize)

  (setq custom-enabled-themes '(tonini-theme))
  )

(add-hook 'cabbage-pre-bundle-hook 'tonini-pre-bundle-hook)
