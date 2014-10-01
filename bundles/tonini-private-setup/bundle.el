(add-to-list 'load-path (cabbage-vendor-library-dir 'emms/lisp))
(require 'emms-setup)
(emms-standard)
(emms-default-players)

(progn
  (setq emms-player-vlc-command-name
        "/Applications/VLC.app/Contents/MacOS/VLC")
  (emms-player-for '(*track* (type . file) (name . "foo.mp3"))))
