(require 'cask "~/.cask/cask.el")

(cask-initialize)

(require 'pallet)

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
(require 'keybindings-prt)
