(set-module-dir (merge-pathnames ".config/stumpwm/modules/"
		  (user-homedir-pathname)))

(set-prefix-key (kbd "s-a"))

;; prompt the user for an interactive command. The first arg is an
;; optional initial contents.
(defcommand colon1 (&optional (initial "")) (:rest)
  (let ((cmd (read-one-line (current-screen) ": " :initial-input initial)))
    (when cmd
      (eval-command cmd t))))

(ql:quickload "slynk")

(defcommand slynk (port) ((:string "Port number: "))
  (sb-thread:make-thread
   (lambda ()
     (slynk:create-server :port (parse-integer port) :dont-close t))
   :name "slynk-manual"))


;; Just stole it from the source code
(defcommand renumber-group (nt) ((:number "Number: "))
  "Change the current group's number to the specified number. If another group
is using the number, then the groups swap numbers."
  (let ((nf (group-number (current-group)))
        (win (find-if #'(lambda (win)
                          (= (group-number win) nt))
                      (screen-groups (current-screen)))))
    ;; Is it already taken?
    (if win
        (progn
          ;; swap the window numbers
          (setf (group-number win) nf)
          (setf (group-number (current-group)) nt))
        ;; Just give the window the number
        (setf (group-number (current-group)) nt))))
