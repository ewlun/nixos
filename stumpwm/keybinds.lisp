;; Groups/workspaces
(define-key *top-map* (kbd "s-1") "gselect 1")
(define-key *top-map* (kbd "s-2") "gselect 2")
(define-key *top-map* (kbd "s-3") "gselect 3")
(define-key *top-map* (kbd "s-4") "gselect 4")
(define-key *top-map* (kbd "s-5") "gselect 5")
(define-key *top-map* (kbd "s-6") "gselect 6")
(define-key *top-map* (kbd "s-7") "gselect 7")
(define-key *top-map* (kbd "s-8") "gselect 8")
(define-key *top-map* (kbd "s-9") "gselect 9")

(define-key *top-map* (kbd "s-!") "gmove 1")
(define-key *top-map* (kbd "s-\"") "gmove 2")
(define-key *top-map* (kbd "s-#") "gmove 3")
(define-key *top-map* (kbd "s-currency") "gmove 4")
(define-key *top-map* (kbd "s-%") "gmove 5")
(define-key *top-map* (kbd "s-&") "gmove 6")
(define-key *top-map* (kbd "s-/") "gmove 7")
(define-key *top-map* (kbd "s-(") "gmove 8")
(define-key *top-map* (kbd "s-)") "gmove 9")

;; Frames & windows
(define-key *top-map* (kbd "s-h") "move-focus left")
(define-key *top-map* (kbd "s-l") "move-focus right")
(define-key *top-map* (kbd "s-k") "move-focus up")
(define-key *top-map* (kbd "s-j") "move-focus down")

;; Launching
(define-key *top-map* (kbd "s-RET") "exec kitty")
(define-key *root-map* (kbd "b") "exec firefox")
(define-key *root-map* (kbd "s-x") "colon")
