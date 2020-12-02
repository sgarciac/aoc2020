;;;; day2.lisp

(in-package #:day2)

;; part1

(defstruct entry
	min
	max
	letter
	word
	)

(defun parse-line (line)
	(multiple-value-bind (line parts) (scan-to-strings "(\\d+)-(\\d+) (.): (.+)" line)
		(make-entry
		 :min (parse-integer (aref parts 0))
		 :max (parse-integer (aref parts 1))
		 :letter (aref (aref parts 2) 0)
		 :word (aref parts 3)
		 )))

(defun read-input (filename)
	(with-open-file (stream filename)
		(loop for line = (read-line stream nil)
					while line
					collect (parse-line line))))

(defvar *input* (read-input "input"))

(defun valid-entry-p (entry)
	(let ((letter-in-word-count (count (entry-letter entry) (entry-word entry))))
		(and
		 (>= letter-in-word-count (entry-min entry))
		 (<= letter-in-word-count (entry-max entry)))))

(defun valid-entries-count (entries)
	(count-if #'valid-entry-p entries))

;; part2

(defstruct entry-p2
	first
	second
	letter
	word
	)

(defun parse-line-p2 (line)
	(multiple-value-bind (line parts) (scan-to-strings "(\\d+)-(\\d+) (.): (.+)" line)
		(make-entry-p2
		 :first (parse-integer (aref parts 0))
		 :second (parse-integer (aref parts 1))
		 :letter (aref (aref parts 2) 0)
		 :word (aref parts 3)
		 )))

(defun read-input-p2 (filename)
	(with-open-file (stream filename)
		(loop for line = (read-line stream nil)
					while line
					collect (parse-line-p2 line))))

(defvar *input-p2* (read-input-p2 "input"))

(defun valid-entry-p2-p (entry)
	(let ((first-match (if (eq (aref (entry-p2-word entry) (1- (entry-p2-first entry)))
														 (entry-p2-letter entry))
												 1 0
												 ))
				(second-match (if (eq (aref (entry-p2-word entry) (1- (entry-p2-second entry)))
															(entry-p2-letter entry))
													1 0)))
		(= 1 (+ first-match second-match))))

(defun valid-entries-p2-count (entries)
	(count-if #'valid-entry-p2-p entries))


;; solutions
(valid-entries-count *input*)

(valid-entries-p2-count *input-p2*)
