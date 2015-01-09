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

(defun t-newline-and-indent ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

;; http://rejeep.github.io/emacs/elisp/2010/03/11/duplicate-current-line-or-region-in-emacs.html
(defun t-duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(defun t-move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (beginning-of-line)
    (when (or (> arg 0) (not (bobp)))
      (forward-line)
      (when (or (< arg 0) (not (eobp)))
        (transpose-lines arg))
      (forward-line -1)))))

(defun t-move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (t-move-text-internal arg))

(defun t-move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (t-move-text-internal (- arg)))

(defun t-indent-buffer ()
  "Indent each nonblank line in the buffer. See `indent-region"
  (interactive)
  (indent-region (point-min) (point-max)))

(provide 'utils-prt)

;;; utils-prt.el ends here
