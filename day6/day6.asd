;;;; day6.asd

(asdf:defsystem #:day6
  :description "Describe day6 here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
	:depends-on (#:alexandria #:split-sequence #:cl-ppcre)
  :version "0.0.1"
  :serial t
  :components ((:file "package")
               (:file "day6")))
