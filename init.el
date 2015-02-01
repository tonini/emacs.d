;;; init.el --- Personal emacs configuration of Samuel Tonini

;;; Commentary:
;;

;;; Code:

(require 'cask "~/.cask/cask.el")

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
(require 'guide-key-prt)
(require 'utils-prt)
(require 'popwin-prt)
(require 'keybindings-prt)
(require 'custom-prt)

(provide 'init)

;;; init.el ends here
