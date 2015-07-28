;;; init.el --- Personal emacs configuration of Samuel Tonini

;;; Commentary:
;;

;;; Code:

(setq package-enable-at-startup nil)
(package-initialize)

(require 'cask "/usr/local/share/emacs/site-lisp/cask.el")
(cask-initialize)

(add-to-list 'load-path (expand-file-name "parts" user-emacs-directory))

(require 'programming-prt)
(require 'project-prt)
(require 'ido-prt)
(require 'completion-prt)
(require 'system-prt)
(require 'display-prt)
(require 'ruby-prt)
(require 'elixir-prt)
(require 'emacs-lisp-prt)
(require 'js-prt)
(require 'coffee-prt)
(require 'yasnippet-prt)
(require 'which-key-prt)
(require 'utils-prt)
(require 'popwin-prt)
(require 'writer-prt)
(require 'custom-prt)
(require 'org-prt)
(require 'dired-prt)
(require 'grep-prt)
(require 'keybindings-prt)

(provide 'init)

;;; init.el ends here
