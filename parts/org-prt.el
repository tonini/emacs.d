;;; org-prt.el --- Org-Mode configurations

;;; Commentary:
;;

;;; Code:

(add-to-list 'Info-default-directory-list "~/info")

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key "\M-a" 'smex)))

;; Fontify the source code inside org-mode source blocks
(setq org-src-fontify-natively t)

(eval-after-load "org-present"
  '(progn

     ;; My custom overlays function
     (defun org-present-add-overlays ()
       "Add overlays for this mode."
       (add-to-invisibility-spec '(org-present))
       (save-excursion
         ;; hide org-mode options starting with #+
         (goto-char (point-min))
         (while (re-search-forward "^[[:space:]]*\\(#\\+\\)\\([^[:space:]]+\\).*" nil t)
           (let ((end (if (org-present-show-option (match-string 2)) 2 0)))
             (org-present-add-overlay (match-beginning 1) (match-end end))))
         ;; hide stars in headings
         (goto-char (point-min))
         (while (re-search-forward "^\\(*+\\)" nil t)
           (org-present-add-overlay (match-beginning 1) (match-end 1)))
         ;; hide tags in headings
         (goto-char (point-min))
         (while (re-search-forward "\\(\:SLIDE\:.+\:\\)$" nil t)
           (org-present-add-overlay (match-beginning 1) (match-end 1)))
         ;; hide emphasis markers
         (goto-char (point-min))
         (while (re-search-forward org-emph-re nil t)
           (org-present-add-overlay (match-beginning 2) (1+ (match-beginning 2)))
           (org-present-add-overlay (1- (match-end 2)) (match-end 2)))))

     (define-key org-present-mode-keymap (kbd "M-l")     'org-present-next)
     (define-key org-present-mode-keymap (kbd "M-j")     'org-present-prev)
     (define-key org-present-mode-keymap (kbd "M-i")     'org-present-beginning)
     (define-key org-present-mode-keymap (kbd "M-k")     'org-present-end)

     (add-hook 'org-present-mode-hook
               (lambda ()
                 (linum-mode -1)
                 (global-hl-line-mode -1)
                 (writeroom-mode t)
                 ;; (visual-line-mode t)
                 (org-display-inline-images)
                 (org-present-hide-cursor)
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                 (global-hl-line-mode t)
                 (linum-mode t)
                 (writeroom-mode -1)
                 ;; (visual-line-mode -1)
                 (org-remove-inline-images)
                 (org-present-show-cursor)
                 (org-present-read-write)))))

(load-file "~/Projects/emacs.d/vendor/ox-texinfo+.el")
(require 'ox-texinfo+)

(provide 'org-prt)

;;; org-prt.el ends here
