;;;; day5.lisp

(in-package #:day5)

(defun to-number (string zero-val one-val)
	(read-from-string
	 (format nil
					 "#b~A"
					 (substitute
						#\1 one-val
						(substitute #\0 zero-val string)))))

(defun row-col (line)
	(values (to-number (subseq line 0 7) #\F #\B )
					(to-number (subseq line 7) #\L #\R)))

(defun seat-number (line)
	(multiple-value-bind (row col) (row-col line)
		(+ (* row 8) col)))

;; part 1
(with-open-file (stream "input")
	(loop for line = (read-line stream nil)
				while line
				maximizing (seat-number line)))

;; part 2
(let ((seats (sort (with-open-file (stream "input")
										 (loop for line = (read-line stream nil)
													 while line
													 collecting	 (seat-number line)))
									 #'<
									 )))
	(loop for (s1 s2) on seats by #'cdr
				while s2
				while (= s2 (1+ s1))
				finally (return (1+ s1))))
