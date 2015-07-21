;;; display-prt.el --- Display setup

;;; Commentary:
;;

;;; Code:

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
(tool-bar-mode 0)

(set-frame-parameter nil 'fullscreen 'fullboth)
(setq default-cursor-type 'box)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'ujelly t)

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

;; Display current git branch and changes for current file in mode-line

(defun t-git-repo-has-changes-p ()
  "Return non-nil if the current git repository have changes."
  (let ((changes (shell-command-to-string "git status --porcelain")))
    (not (string-empty-p changes))))

(defface t-git-branch-has-changes-face
  '((t (:inherit font-lock-variable-name-face :weight normal)))
  "Face for branch when uncommited changes exists.")

(defface t-git-branch-has-no-changes-face
  '((t (:inherit font-lock-builtin-face :foreground "#99ad6a" :weight normal)))
  "Face for branch when no changes exists.")

(defun t-format-git-mode-line (git-mode-line)
  (let* ((git-mode-line (replace-regexp-in-string "\\(Git-\\|Git:\\)" "" git-mode-line))
         (branch (car (split-string git-mode-line " ")))
         (changes (car (cdr (split-string git-mode-line " ")))))
    (concat "[git:"
            (if (t-git-repo-has-changes-p)
                (propertize branch 'face 't-git-branch-has-changes-face)
              (propertize branch 'face 't-git-branch-has-no-changes-face))
            (when changes
              (format " %s" changes))
            "]")))

;; source: http://superuser.com/questions/576953/how-do-i-show-the-git-status-in-the-emacs-bottom-bar
(defadvice vc-git-mode-line-string (after plus-minus (file) compile activate)
  (setq ad-return-value
        (t-format-git-mode-line
         (concat ad-return-value
                 (let ((plus-minus (vc-git--run-command-string
                                    file "diff" "--numstat" "--")))
                   (and plus-minus
                        (string-match "^\\([0-9]+\\)\t\\([0-9]+\\)\t" plus-minus)
                        (format " +%s-%s" (match-string 1 plus-minus) (match-string 2 plus-minus))))))))

(provide 'display-prt)

;;; display-prt.el ends here
