(defun tonini-toggle-fullscreen ()
  "Toggle full screen."
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

(defun tonini-browse-localhost-port-3000 ()
  (interactive)
  (browse-url "http://localhost:3000"))

(defun tonini-rgrep-todos-in-dir (dir)
  "Grep recursively for TODO comments in the given directory"
  (interactive "Ddirectory:")
  (grep (concat "grep -nH -I -r -E \"[\\#\\/\\-\\;\\*]\s*TODO|FIXME|BUG|WARNING:?\" " dir " 2>/dev/null"))
  (enlarge-winqdow 7))

(require 'url)

(defun tonini-fetch-snippet (url)
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

(defun tonini-fetch-file (url)
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

(defun tonini-project-ido-find-project ()
  (interactive)
  (let* ((project-name (ido-completing-read "Project: "
                                            (directory-files cabbage-project-location nil "^[^.]")))
         (project-path (concat cabbage-project-location project-name)))
    (cabbage-persp project-name)
    (let ((default-directory project-path))
      (textmate-goto-file))))
