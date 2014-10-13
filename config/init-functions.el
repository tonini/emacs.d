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

(provide 'init-functions)
