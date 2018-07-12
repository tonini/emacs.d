(require 'cl)
(require 'idle-highlight-mode)
(require 'zoom-window)

;; zoom-window configuration
(setq zoom-window-mode-line-color "DarkGreen")

(setq-default truncate-lines t)
(setq visible-bell nil)
(transient-mark-mode 1)
(show-paren-mode 1)
(idle-highlight-mode 1)
(column-number-mode 1)

(setq use-dialog-box nil
      visible-bell t
      echo-keystrokes 0.1
      inhibit-startup-message t
      truncate-partial-width-windows nil
      gnuserv-frame (car (frame-list)))

(global-hl-line-mode t)

(menu-bar-mode -1)
(tool-bar-mode -1)

(set-frame-parameter nil 'fullscreen 'fullboth)
(setq default-cursor-type 'box)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; (load-theme 'ujelly t)

(defvar mode-line-cleaner-alist
  `((eldoc-mode . "")
    (rainbow-mode . "")
    (overseer-mode . "")
    (alchemist-mode . "")
    (guide-key-mode . "")
    (elisp-slime-nav-mode . "")
    (rainbow-mode . "")
    (company-mode . "")
    (yas/minor-mode . "")
    (projectile-mode . "")
    (flycheck-mode . "")
    (ruby-tools-mode . "")
    (rinari-minor-mode . "")
    (smartparens-mode . "")
    (remove-trailing-whitespace-mode . "")
    (abbrev-mode . "")
    ;; Major modes
    (ruby-mode . "♦")
    (lisp-interaction-mode . "λ")
    (emacs-lisp-mode . "EL")
    (nxhtml-mode . "nx"))
  "Alist for `clean-mode-line'.

When you add a new element to the alist, keep in mind that you
must pass the correct minor/major mode symbol and a string you
want to use in the modeline *in lieu of* the original.")

(defun clean-mode-line ()
  (interactive)
  (cl-loop for cleaner in mode-line-cleaner-alist
        do (let* ((mode (car cleaner))
                  (mode-str (cdr cleaner))
                  (old-mode-str (cdr (assq mode minor-mode-alist))))
             (when old-mode-str
               (setcar old-mode-str mode-str))
             ;; major mode
             (when (eq mode major-mode)
               (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)

(setq linum-format " %d ")
(global-linum-mode)

(eval
 '(set-display-table-slot standard-display-table
                          'vertical-border
                          (make-glyph-code ?┃)))

;; Smartparens faces
;;
;; - disable pair overlay for readability
(setq sp-highlight-pair-overlay nil)

;; Flycheck faces
;;
;; - flycheck-warning
;; - flycheck-error
;; - flycheck-info
;;
(eval-after-load 'flycheck
    '(progn
      (set-face-attribute 'flycheck-warning nil :foreground "yellow" :underline nil)))

(defun tonini-after-init-setup ()
  "Some setup after Emacs init."
  (menu-bar-mode -1))

(add-hook 'after-init-hook 'tonini-after-init-setup)


(provide 'tonini-display-prt)
