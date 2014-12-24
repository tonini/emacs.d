;;; utils-prt.el --- Useful functions

;;; Commentary:
;; 

;;; Code:

(require 'url)

(defun t-comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
	(setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))

(defun t-fetch-snippet (url)
  (interactive "MEnter snippet URL: ")
  (let ((download-buffer (url-retrieve-synchronously url))
        (download-dir (read-directory-name "Enter snippet directory: " "~/.emacs.d/snippets/")))
    (save-excursion
      (set-buffer download-buffer)
      (goto-char (point-min))
      (re-search-forward "^$" nil 'move)
      (forward-char)
      (delete-region (point-min) (point))
      (write-file (concat download-dir
                          (car (last (split-string url "/" t)))))))
  (yas/reload-all))

(defun t-fetch-file (url)
  (interactive "MEnter URL: ")
  (let ((download-buffer (url-retrieve-synchronously url))
        (download-dir (read-directory-name "Enter download directory: " "~/Downloads/")))
    (save-excursion
      (set-buffer download-buffer)
      (goto-char (point-min))
      (re-search-forward "^$" nil 'move)
      (forward-char)
      (delete-region (point-min) (point))
      (write-file (concat download-dir
                          (car (last (split-string url "/" t))))))))

(provide 'utils-prt)

;;; utils-prt.el ends here
