(add-to-list 'cabbage-bundle-dirs (expand-file-name "~/.emacs.d/bundles/"))
(add-to-list 'cabbage-bundle-dirs (expand-file-name "~/Projects/cabbage-contrib/bundles/"))
(add-to-list 'cabbage-vendor-dirs (expand-file-name "~/.emacs.d/vendor/"))
(add-to-list 'cabbage-vendor-dirs (expand-file-name "~/Projects/cabbage-contrib/vendor/"))

;; `gc-cons-threshold'
;;
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Garbage-Collection.html
;;
;; I have a modern machine ;)
;;
(setq gc-cons-threshold 20000000)

(setq tonini-vendor-dir
      (expand-file-name "~/.emacs.d/vendor/"))

(setq tonini-cabbage-private-dir
      (expand-file-name "~/.emacs.d/private/"))

(defun tonini-load-private-setup ()
  ;; Load all *.el file under the private directory
  (dolist (file (directory-files tonini-cabbage-private-dir t "\\.el$"))
    (load file))

  (setq rspec-use-bundler-when-possible t))

(add-hook 'cabbage-initialized-hook 'tonini-load-private-setup)
