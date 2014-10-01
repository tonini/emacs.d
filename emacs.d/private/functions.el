(defun tonini-toggle-fullscreen ()
  "Toggle full screen."
  (interactive)
  (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

(defun tonini-browse-localhost-port-3000 ()
  (interactive)
  (browse-url "http://localhost:3000"))
