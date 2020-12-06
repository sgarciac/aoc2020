;;;; day6.lisp

(in-package #:day6)

(setf *lines* (with-open-file (stream "input")
								(loop for line = (read-line stream nil)
											while line
											collecting line)))

(setf *groups* (split-sequence:split-sequence ""
																							*lines*
																							:test #'string=))
;; part 1
(defun score (group)
	(length (remove-duplicates (apply #'concatenate 'string group))))

(loop for group in *groups* summing (score group))

;; part 2
(defun full-intersection (list)
	(if (not (cdr list))
			(car list)
			(full-intersection
			 (cons (intersection (first list) (second list))
						 (cddr list)))))


(defun score-2 (group)
	(length (full-intersection (mapcar (lambda (entry) (map 'list #'identity entry)) group))))

(loop for group in *groups* summing (score-2 group))
