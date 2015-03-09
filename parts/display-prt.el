;;; display-prt.el --- Display setup

;;; Commentary:
;;

;;; Code:

(require 'cl)
(require 'idle-highlight-mode)

(winner-mode 1)

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
(tool-bar-mode 0)

(set-frame-parameter nil 'fullscreen 'fullboth)
(setq default-cursor-type 'box)

(load (expand-file-name "~/.emacs.d/themes/github.el"))

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

;; (set-display-table-slot standard-display-table 'vertical-border (make-glyph-code ?\s))

(defun linum-format-func (line)
  (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
     (propertize (format (format "%%%dd " w) line) 'face 'linum)))

(setq linum-format 'linum-format-func)
(global-linum-mode t)

(provide 'display-prt)

;;; display-prt.el ends here
