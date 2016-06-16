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

;; Customization
(defconst tonini-custom-file (locate-user-emacs-file "customize.el")
  "File used to store settings from Customization UI.")

(setq temporary-file-directory (expand-file-name "~/.emacs.d/tmp"))
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'tonini-utils)
(require 'tonini-keybindings)

(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold 800000))

(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)

;;; User interface

;; Get rid of tool bar, menu bar and scroll bars.  On OS X we preserve the menu
;; bar, since the top menu bar is always visible anyway, and we'd just empty it
;; which is rather pointless.
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (and (eq system-type 'darwin) (fboundp 'menu-bar-mode))
  (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(set-default 'truncate-lines t)

(delete-selection-mode 1)
(transient-mark-mode 1)
;; No blinking and beeping, no startup screen, no scratch message and short
;; Yes/No questions.
(blink-cursor-mode 1)
(setq ring-bell-function #'ignore
      inhibit-startup-screen t
      echo-keystrokes 0.1
      linum-format " %d"
      initial-scratch-message "Howdy Sam!\n")
(fset 'yes-or-no-p #'y-or-n-p)
;; Opt out from the startup message in the echo area by simply disabling this
;; ridiculously bizarre thing entirely.
(fset 'display-startup-echo-area-message #'ignore)

(global-linum-mode)

(set-face-attribute 'default nil
                    :family "Source Code Pro" :height 160)
(set-face-attribute 'variable-pitch nil
                    :family "Fira Sans" :height 140 :weight 'regular)

(set-frame-parameter nil 'fullscreen 'fullboth)

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; utf-8 all the things
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

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

(use-package page-break-lines           ; Turn page breaks into lines
  :ensure t
  :init (global-page-break-lines-mode)
  :diminish page-break-lines-mode)

(use-package cus-edit
  :defer t
  :config
  (setq custom-file tonini-custom-file
        custom-buffer-done-kill nil            ; Kill when existing
        custom-buffer-verbose-help nil         ; Remove redundant help text
        ;; Show me the real variable name
        custom-unlispify-tag-names nil
        custom-unlispify-menu-entries nil)
  :init (load tonini-custom-file 'no-error 'no-message))

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
  :bind
  (:map smartparens-mode-map
	("C-c s u" . sp-unwrap-sexp)
	("C-c s w" . sp-rewrap-sexp))
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
  (dolist (hook '(text-mode-hook prog-mode-hook emacs-lisp-mode-hook))
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
  (progn
    (delete 'company-dabbrev company-backends)
    (setq company-tooltip-align-annotations t
	  company-tooltip-minimum-width 27
	  company-idle-delay 0.3
	  company-tooltip-limit 10
	  company-minimum-prefix-length 2
	  company-tooltip-flip-when-above t))
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

(use-package helm-info
  :ensure helm
  :bind (([remap info] . helm-info-at-point)
         ("C-c h e"    . helm-info-emacs))
  :config
  ;; Also lookup symbols in the Emacs manual
  (add-to-list 'helm-info-default-sources
               'helm-source-info-emacs))

(use-package helm-flycheck              ; Helm frontend for Flycheck errors
  :ensure t
  :defer t
  :after flycheck)

(use-package winner                     ; Undo and redo window configurations
  :init (winner-mode))

(use-package desktop                    ; Save buffers, windows and frames
  :disabled t
  :init (desktop-save-mode)
  :config
  ;; Save desktops a minute after Emacs was idle.
  (setq desktop-auto-save-timeout 60)

  ;; Don't save Magit and Git related buffers
  (dolist (mode '(magit-mode magit-log-mode))
    (add-to-list 'desktop-modes-not-to-save mode))
  (add-to-list 'desktop-files-not-to-save (rx bos "COMMIT_EDITMSG")))


(use-package multiple-cursors           ; Edit text with multiple cursors
  :ensure t
  :bind (("C-c o <SPC>" . mc/vertical-align-with-space)
         ("C-c o a"     . mc/vertical-align)
         ("C-c o e"     . mc/mark-more-like-this-extended)
         ("C-c o h"     . mc/mark-all-like-this-dwim)
         ("C-c o l"     . mc/edit-lines)
         ("C-c o n"     . mc/mark-next-like-this)
         ("C-c o p"     . mc/mark-previous-like-this)
         ("C-c o r"     . vr/mc-mark)
         ("C-c o C-a"   . mc/edit-beginnings-of-lines)
         ("C-c o C-e"   . mc/edit-ends-of-lines)
         ("C-c o C-s"   . mc/mark-all-in-region))
  :config
  (setq mc/mode-line
        ;; Simplify the MC mode line indicator
        '(:propertize (:eval (concat " " (number-to-string (mc/num-cursors))))
                      face font-lock-warning-face)))

;; (use-package autorevert                 ; Auto-revert buffers of changed files
;;   :init (global-auto-revert-mode)
;;   :config
;;   (setq auto-revert-verbose nil         ; Shut up, please!
;;         ;; Revert Dired buffers, too
;;         global-auto-revert-non-file-buffers t)

  ;; (when (eq system-type 'darwin)
  ;;   ;; File notifications aren't supported on OS X
  ;;   (setq auto-revert-use-notify nil))
  ;; :diminish (auto-revert-mode))

(use-package subword                    ; Subword/superword editing
  :defer t
  :diminish subword-mode)

(use-package ibuffer-vc                 ; Group buffers by VC project and status
  :disabled t
  :ensure t
  :defer t
  :init (add-hook 'ibuffer-hook
                  (lambda ()
                    (ibuffer-vc-set-filter-groups-by-vc-root)
                    (unless (eq ibuffer-sorting-mode 'alphabetic)
                      (ibuffer-do-sort-by-alphabetic)))))

(use-package projectile
  :ensure t
  :bind (("C-x p" . projectile-persp-switch-project))
  :config
  (setq projectile-completion-system 'helm)
  (projectile-global-mode)
  (helm-projectile-on)
  (setq projectile-enable-caching nil)
  :diminish (projectile-mode))

(use-package ibuffer-projectile         ; Group buffers by Projectile project
  :ensure t
  :defer t
  :init (add-hook 'ibuffer-hook #'ibuffer-projectile-set-filter-groups))

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
  (yas-global-mode 1)
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
  :bind (:map erlang-mode-map ("M-," . alchemist-goto-jump-back))
  :config
  (setq erlang-indent-level 2))

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

(use-package solarized-theme
  :ensure t
  :defer t
  :init (load-theme 'solarized-dark t)
  :config
  ;; make the fringe stand out from the background
  (setq solarized-distinct-fringe-background t)

  ;; Don't change the font for some headings and titles
  (setq solarized-use-variable-pitch nil)

  ;; Use less colors for indicators such as git:gutter, flycheck and similar
  (setq solarized-emphasize-indicators nil)

  ;; Don't change size of org-mode headlines (but keep other size-changes)
  (setq solarized-scale-org-headlines nil)

  ;; Avoid all font-size changes
  (setq solarized-height-minus-1 1)
  (setq solarized-height-plus-1 1)
  (setq solarized-height-plus-2 1)
  (setq solarized-height-plus-3 1)
  (setq solarized-height-plus-4 1))

;;; OS X support
(use-package ns-win                     ; OS X window support
  :defer t
  :if (eq system-type 'darwin)
  :config
  (setq ns-pop-up-frames nil            ; Don't pop up new frames from the
                                        ; workspace
        mac-option-modifier 'meta       ; Option is simply the natural Meta
        mac-command-modifier 'meta      ; But command is a lot easier to hit
        mac-right-command-modifier 'left
        mac-right-option-modifier 'none ; Keep right option for accented input
        ;; Just in case we ever need these keys
        mac-function-modifier 'hyper))

;;; Environment fixup
(use-package exec-path-from-shell
  :ensure t
  :if (and (eq system-type 'darwin) (display-graphic-p))
  :config
  (progn
    (when (string-match-p "/zsh$" (getenv "SHELL"))
      ;; Use a non-interactive login shell.  A login shell, because my
      ;; environment variables are mostly set in `.zprofile'.
      (setq exec-path-from-shell-arguments '("-l")))

    (dolist (var '("EMAIL" "INFOPATH" "JAVA_OPTS"))
      (add-to-list 'exec-path-from-shell-variables var))

    (exec-path-from-shell-initialize)

    (setq user-mail-address (getenv "EMAIL"))

    ;; Re-initialize the `Info-directory-list' from $INFOPATH.  Since package.el
    ;; already initializes info, we need to explicitly add the $INFOPATH
    ;; directories to `Info-directory-list'.  We reverse the list of info paths
    ;; to prepend them in proper order subsequently
    (with-eval-after-load 'info
      (dolist (dir (nreverse (parse-colon-path (getenv "INFOPATH"))))
        (when dir
          (add-to-list 'Info-directory-list dir))))))

(use-package default-text-scale
  :ensure t)

(use-package overseer
  :ensure t
  :init
  (progn
    (defun test-emacs-lisp-hook ()
      (tester-init-test-run #'overseer-test-file "-test.el$")
      (tester-init-test-suite-run #'overseer-test))
    (add-hook 'overseer-mode-hook 'test-emacs-lisp-hook)))

(use-package karma
  :ensure t
  :init)

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
         ("\\.jsx\\'" . js2-jsx-mode))
  :bind (:map js2-mode-map
	      ("M-j" . backward-char))
  :config (setq js2-basic-offset 2))

(use-package typescript-mode
  :ensure t
  :config (setq typescript-indent-level 2))

(use-package coffee-mode
  :ensure t
  :mode (("\\.coffee\\'" . coffee-mode)
         ("\\.coffee.erb\\'" . coffee-mode)))

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
  :config
  (progn
    (delete 'Git vc-handled-backends)))

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

(use-package emmet-mode
  :ensure t
  :bind (:map emmet-mode-keymap
	      ("M-e" . emmet-expand-line))
  :config (add-hook 'web-mode-hook 'emmet-mode))

(use-package sass-mode
  :ensure t)

(use-package whitespace-cleanup-mode
  :ensure t
  :bind (("C-c t c" . whitespace-cleanup-mode)
         ("C-c x w" . whitespace-cleanup))
  :init (dolist (hook '(prog-mode-hook text-mode-hook conf-mode-hook))
          (add-hook hook #'whitespace-cleanup-mode))
  :diminish (whitespace-cleanup-mode))

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode))

(provide 'init)

;;; init.el ends here
