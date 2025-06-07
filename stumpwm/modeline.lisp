(defun show-battery-charge ()
  (remove #\newline (run-shell-command "sh /home/edwin/show_battery.sh" t)))

(setf *window-format* "%m%20t")

(setf *time-modeline-string* "%a %e %b %k:%M")

(setf *screen-mode-line-format*
      (list
       "[^B^7%g^b] [ ^B^7%W^b ]"
       "^>"
       '(:eval (format nil "^B^7| Battery: ~D% " (show-battery-charge)))
       "^7| %d"
       ))

(setf *mode-line-pad-x* 5
      *mode-line-pad-y* 10)

(setf *mode-line-timeout* 10)
(enable-mode-line (current-screen) (current-head) t)
