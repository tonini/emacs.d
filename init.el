;;; init.el --- Personal emacs configuration of Samuel Tonini

;; Copyright © 2014-2015 Samuel Tonini
;;
;; Author: Samuel Tonini <tonini.samuel@gmail.com>
;; Maintainer: Samuel Tonini <tonini.samuel@gmail.com>
;; URL: http://www.github.com/tonini/emacs.d

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Personal emacs configuration of Samuel Tonini

;;; Code:

(setq package-enable-at-startup nil)
(package-initialize)

(require 'cask "/usr/local/share/emacs/site-lisp/cask.el")
(cask-initialize)

(require 'pallet)
(pallet-mode t)

(add-to-list 'load-path (expand-file-name "parts" user-emacs-directory))

(require 'smartparens-prt)
(require 'magit-prt)
(require 'programming-prt)
(require 'project-prt)
(require 'completion-prt)
(require 'system-prt)
(require 'display-prt)
(require 'ruby-prt)
(require 'elixir-prt)
(require 'emacs-lisp-prt)
(require 'js-prt)
(require 'coffee-prt)
(require 'yasnippet-prt)
(require 'utils-prt)
(require 'writer-prt)
(require 'custom-prt)
(require 'org-prt)
(require 'dired-prt)
(require 'grep-prt)
(require 'keybindings-prt)
(require 'helm-prt)
(require 'html-prt)

(provide 'init)

;;; init.el ends here
