;;;; day2.asd

(asdf:defsystem #:day2
	:depends-on ("cl-ppcre")
  :description "Describe day2 here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
               (:file "day2")))
