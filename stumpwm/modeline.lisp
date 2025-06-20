(defun show-battery-charge ()
  (remove #\newline (run-shell-command "sh /home/edwin/show_battery.sh" t)))

(setf *window-format* "%m%20t")

(defun time-day-of-month-no-pad ()
  (format nil "~D" (getf (time-plist) :dom)))

(setf *time-format-string-alist*
      (append *time-format-string-alist* '((#\E time-day-of-month-no-pad))))

(setf *time-modeline-string* "%a %E %b %k:%M")

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


(defun set-alpha-bits (color alpha)
  (+ (logand color (- (ash 1 24) 1))
     (ash alpha 24)))

(enable-mode-line (current-screen) (current-head) t)
