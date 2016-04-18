;;; init.el --- Personal emacs configuration of Samuel Tonini

;; Copyright © 2014-2016 Samuel Tonini
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

;; Personal Emacs configuration of Samuel Tonini

;;; Code:

;;; Debugging
(setq message-log-max 10000)

;; Please don't load outdated byte code
(setq load-prefer-newer t)

(setq temporary-file-directory (expand-file-name "~/.emacs.d/tmp"))
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'tonini-utils)
(require 'tonini-keybindings)

;; Display setup

(if window-system
    (progn
      (setq frame-title-format '(buffer-file-name "%f" ("%b")))
      (tooltip-mode -1)
      (mouse-wheel-mode t)
      (scroll-bar-mode -1))
  (menu-bar-mode -1))

(setq use-dialog-box nil
      visible-bell t
      echo-keystrokes 0.1
      inhibit-startup-message t
      truncate-partial-width-windows nil
      gnuserv-frame (car (frame-list))
      linum-format " %d ")

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(blink-cursor-mode -1)
(global-hl-line-mode t)
(delete-selection-mode 1)
(transient-mark-mode 1)
(show-paren-mode 1)
(column-number-mode 1)
(global-linum-mode)

(setq-default cursor-type '(bar . 2))

(eval
 '(set-display-table-slot standard-display-table
                          'vertical-border
                          (make-glyph-code ?┃)))

(defalias 'yes-or-no-p 'y-or-n-p)

(setq inhibit-startup-screen t)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'ujelly t)

;; System setup

;; `gc-cons-threshold'

;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Garbage-Collection.html
;;
;; I have a modern machine ;)
;;
(setq gc-cons-threshold 20000000)

(setq delete-old-versions t
      make-backup-files nil
      create-lockfiles nil
      ring-bell-function 'ignore
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

(server-start) ;; Allow this Emacs process to be a server for client processes.

;; Bootstrap `use-package'
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'diminish)
(require 'bind-key)

(eval-and-compile
  (add-to-list 'load-path (expand-file-name "vendor" user-emacs-directory)))

(use-package smartparens
  :ensure t
  :init
  (smartparens-global-mode)
  (show-smartparens-global-mode)
  (dolist (hook '(inferior-emacs-lisp-mode-hook
                  emacs-lisp-mode-hook))
    (add-hook hook #'smartparens-strict-mode))
  :config
  (require 'smartparens-config)
  (setq sp-autoskip-closing-pair 'always)
  :diminish (smartparens-mode))

(use-package ido
  :config
  (setq ido-enable-flex-matching t)
  (ido-everywhere t)
  (ido-mode 1))

(use-package hl-line
  :init (global-hl-line-mode 1))

(use-package rainbow-delimiters
  :ensure t
  :defer t
  :init
  (dolist (hook '(text-mode-hook prog-mode-hook))
    (add-hook hook #'rainbow-delimiters-mode)))

(use-package hi-lock
  :init (global-hi-lock-mode))

(use-package highlight-numbers
  :ensure t
  :defer t
  :init (add-hook 'prog-mode-hook #'highlight-numbers-mode))

(use-package rainbow-mode
  :ensure t
  :bind (("C-c t r" . rainbow-mode))
  :config (add-hook 'css-mode-hook #'rainbow-mode)
  :diminish (rainbow-mode))

(use-package company                    ; Graphical (auto-)completion
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-tooltip-align-annotations t
	company-idle-delay 0.3
        company-tooltip-limit 10
        company-minimum-prefix-length 2
        company-tooltip-flip-when-above t)
  :bind (:map company-active-map
              ("M-k" . company-select-next)
              ("M-i" . company-select-previous)
              ("TAB" . company-complete-selection))
  :diminish company-mode)

(use-package ag
  :ensure t
  :commands (ag ag-regexp ag-project))

(use-package tester
  :load-path "~/Projects/tester.el"
  :commands (tester-run-test-file tester-run-test-suite))

(use-package helm-core
  :ensure t)
(use-package helm
  :ensure t
  :bind (("M-a" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x f" . helm-recentf)
         ("C-SPC" . helm-dabbrev)
         ("M-y" . helm-show-kill-ring)
         ("C-x b" . helm-buffers-list))
  :bind (:map helm-map
              ("M-i" . helm-previous-line)
              ("M-k" . helm-next-line)
              ("M-I" . helm-previous-page)
              ("M-K" . helm-next-page)
              ("M-h" . helm-beginning-of-buffer)
              ("M-H" . helm-end-of-buffer)
              ("<tab>" . helm-execute-persistent-action)
              ("C-i" . helm-execute-persistent-action))
  :config (progn
            (setq helm-buffers-fuzzy-matching t)
            (helm-mode 1)
	    (setq helm-split-window-in-side-p           t
		  helm-buffers-fuzzy-matching           t
		  helm-move-to-line-cycle-in-source     t
		  helm-ff-search-library-in-sexp        t
		  helm-ff-file-name-history-use-recentf t
		  helm-ag-fuzzy-match                   t)

	    (substitute-key-definition 'find-tag 'helm-etags-select global-map)
	    (setq projectile-completion-system 'helm))
  ;; Display helm buffers always at the bottom
  ;; Source: http://www.lunaryorn.com/2015/04/29/the-power-of-display-buffer-alist.html
  (add-to-list 'display-buffer-alist
               `(,(rx bos "*helm" (* not-newline) "*" eos)
                 (display-buffer-reuse-window display-buffer-in-side-window)
                 (reusable-frames . visible)
                 (side            . bottom)
                 (window-height   . 0.4)))
  :diminish (helm-mode))
(use-package helm-descbinds
  :ensure t
  :bind ("C-h b" . helm-descbinds))
(use-package helm-files
  :bind (:map helm-find-files-map
              ("M-i" . nil)
              ("M-k" . nil)
              ("M-I" . nil)
              ("M-K" . nil)
              ("M-h" . nil)
              ("M-H" . nil)
              ("M-v" . yank)))
(use-package helm-swoop
  :ensure t
  :bind (("M-m" . helm-swoop)
         ("M-M" . helm-swoop-back-to-last-point))
  :init
  (bind-key "M-m" 'helm-swoop-from-isearch isearch-mode-map))
(use-package helm-ag
  :ensure helm-ag
  :bind ("M-p" . helm-projectile-ag)
  :commands (helm-ag helm-projectile-ag)
  :init (setq helm-ag-insert-at-point 'symbol
              helm-ag-command-option "--path-to-agignore ~/.agignore"))

(use-package projectile
  :ensure t
  :bind (("C-x p" . projectile-persp-switch-project))
  :config
  (setq projectile-completion-system 'helm)
  (projectile-global-mode)
  (helm-projectile-on)
  (setq projectile-enable-caching nil)
  :diminish (projectile-mode))

(use-package persp-projectile
  :ensure t
  :defer 1
  :bind (("C-p s" . projectile-persp-switch-project))
  :config
  (persp-mode)
  (defun persp-format-name (name)
    "Format the perspective name given by NAME for display in `persp-modestring'."
    (let ((string-name (format "%s" name)))
      (if (equal name (persp-name persp-curr))
	  (propertize string-name 'face 'persp-selected-face))))

  (defun persp-update-modestring ()
    "Update `persp-modestring' to reflect the current perspectives.
Has no effect when `persp-show-modestring' is nil."
    (when persp-show-modestring
      (setq persp-modestring
	    (append '("[")
		    (persp-intersperse (mapcar 'persp-format-name (persp-names)) "")
		    '("]"))))))

(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))

(use-package elixir-mode
  :load-path "~/Projects/emacs-elixir/"
  :config (progn
	    (yas-minor-mode +1)
	    (defun my-elixir-do-end-close-action (id action context)
	      (when (eq action 'insert)
		(newline-and-indent)
		(forward-line -1)
		(indent-according-to-mode)))

	    (sp-with-modes '(elixir-mode)
	      (sp-local-pair "do" "end"
			     :when '(("SPC" "RET"))
			     :post-handlers '(:add my-elixir-do-end-close-action)
			     :actions '(insert)))))

(use-package yasnippet
  :ensure t
  :defer t
  :config
  (setq yas-snippet-dirs "~/.emacs.d/snippets")
  (yas-global-mode +1)
  :diminish (yas-minor-mode . " YS"))

(use-package alchemist
  :defer 1
  :load-path "~/Projects/alchemist.el/"
  :bind (:map alchemist-iex-mode-map
	      ("C-d" . windmove-right)
	 :map alchemist-mode-map
	      ("M-w" . alchemist-goto-list-symbol-definitions))
  :config (progn
	    (setq alchemist-goto-elixir-source-dir "~/Projects/elixir/")
	    (setq alchemist-goto-erlang-source-dir "~/Projects/otp/")
	    (defun tonini-alchemist-mode-hook ()
	      (tester-init-test-run #'alchemist-mix-test-file "_test.exs$")
	      (tester-init-test-suite-run #'alchemist-mix-test))
            (add-hook 'alchemist-mode-hook 'tonini-alchemist-mode-hook)

	    ;; Display alchemist buffers always at the bottom
	    ;; Source: http://www.lunaryorn.com/2015/04/29/the-power-of-display-buffer-alist.html
	    (add-to-list 'display-buffer-alist
			 `(,(rx bos (or "*alchemist test report*"
					"*alchemist mix*"
					"*alchemist help*"
					"*alchemist elixir*"
					"*alchemist elixirc*"))
			   (display-buffer-reuse-window
			    display-buffer-in-side-window)
			   (reusable-frames . visible)
			   (side            . right)
			   (window-width   . 0.5)))))

(use-package erlang
  :ensure t
  :bind (:map erlang-mode-map ("M-," . alchemist-goto-jump-back)))

(use-package enh-ruby-mode
  :ensure t
  :defer t
  :mode (("\\.rb\\'"       . enh-ruby-mode)
         ("\\.ru\\'"       . enh-ruby-mode)
         ("\\.jbuilder\\'" . enh-ruby-mode)
         ("\\.gemspec\\'"  . enh-ruby-mode)
         ("\\.rake\\'"     . enh-ruby-mode)
         ("Rakefile\\'"    . enh-ruby-mode)
         ("Gemfile\\'"     . enh-ruby-mode)
         ("Guardfile\\'"   . enh-ruby-mode)
         ("Capfile\\'"     . enh-ruby-mode)
         ("Vagrantfile\\'" . enh-ruby-mode))
  :config (progn
            (setq enh-ruby-indent-level 2
                  enh-ruby-deep-indent-paren nil
                  enh-ruby-bounce-deep-indent t
                  enh-ruby-hanging-indent-level 2)
            (setq ruby-insert-encoding-magic-comment nil)))

(use-package rubocop
  :ensure t
  :defer t
  :init (add-hook 'ruby-mode-hook 'rubocop-mode))

(use-package rspec-mode
  :ensure t
  :defer t
  :config (progn
            (defun rspec-ruby-mode-hook ()
              (tester-init-test-run #'rspec-run-single-file "_spec.rb$")
              (tester-init-test-suite-run #'rake-test))
            (add-hook 'enh-ruby-mode-hook 'rspec-ruby-mode-hook)))

(use-package rbenv
  :ensure t
  :defer t
  :init (setq rbenv-show-active-ruby-in-modeline nil)
  :config (progn
            (global-rbenv-mode)
            (add-hook 'enh-ruby-mode-hook 'rbenv-use-corresponding)))

(use-package f
  :ensure t)

(use-package overseer
  :ensure t
  :init
  (progn
    (defun test-emacs-lisp-hook ()
      (tester-init-test-run #'overseer-test-file "-test.el$")
      (tester-init-test-suite-run #'overseer-test))
    (add-hook 'overseer-mode-hook 'test-emacs-lisp-hook)))

(use-package elisp-slime-nav
  :ensure t
  :init (add-hook 'emacs-lisp-mode-hook #'elisp-slime-nav-mode)
  :diminish elisp-slime-nav-mode)

(use-package emacs-lisp-mode
  :defer t
  :interpreter ("emacs" . emacs-lisp-mode)
  :bind (:map emacs-lisp-mode-map
              ("C-c e r" . eval-region)
              ("C-c e b" . eval-buffer)
              ("C-c e e" . eval-last-sexp)
              ("C-c e f" . eval-defun))
  :diminish (emacs-lisp-mode . "EL"))

(use-package cask-mode
  :ensure t
  :defer t)

(use-package macrostep
  :ensure t
  :after elisp-mode
  :bind (:map emacs-lisp-mode-map ("C-c m x" . macrostep-expand)
              :map lisp-interaction-mode-map ("C-c m x" . macrostep-expand)))

(use-package ert
  :after elisp-mode)

(use-package js2-mode
  :ensure t
  :mode (("\\.js\\'" . js2-mode)
         ("\\.js.erb\\'" . js2-mode)
         ("\\.jsx\\'" . js2-jsx-mode)))

(use-package js2-refactor
  :ensure t
  :after js2-mode
  :init
  (add-hook 'js2-mode-hook 'js2-refactor-mode)
  :config
  (js2r-add-keybindings-with-prefix "C-c m r"))

(use-package company-tern
  :disabled t
  :ensure t
  :after company)

(use-package flycheck
  :ensure t
  :defer 5
  :config
  (global-flycheck-mode 1)
  :diminish (flycheck-mode))

(use-package drag-stuff
  :ensure t
  :bind (("M-<up>" . drag-stuff-up)
         ("M-<down>" . drag-stuff-down)))

(use-package magit
  :ensure t
  :defer 2
  :bind (("C-x g" . magit-status))
  :config (progn
            (magit-wip-after-save-mode)
            (magit-wip-after-apply-mode)
            (magit-wip-before-change-mode)))

(use-package yaml-mode
  :ensure t
  :mode ("\\.ya?ml\\'" . yaml-mode))

(use-package web-mode
  :ensure t
  :mode (("\\.erb\\'" . web-mode)
         ("\\.mustache\\'" . web-mode)
         ("\\.html?\\'" . web-mode)
         ("\\.eex\\'" . web-mode)
         ("\\.php\\'" . web-mode))
  :config (progn
            (setq web-mode-markup-indent-offset 2
                  web-mode-css-indent-offset 2
                  web-mode-code-indent-offset 2)))

(use-package whitespace-cleanup-mode
  :ensure t
  :bind (("C-c t c" . whitespace-cleanup-mode)
         ("C-c x w" . whitespace-cleanup))
  :init (dolist (hook '(prog-mode-hook text-mode-hook conf-mode-hook))
          (add-hook hook #'whitespace-cleanup-mode))
  :diminish (whitespace-cleanup-mode))

(use-package markdown-mode
  :ensure t)

(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(load custom-file)

(provide 'init)

;;; init.el ends here
