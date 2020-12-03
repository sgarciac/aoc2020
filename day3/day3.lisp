;;;; day3.lisp

(in-package #:day3)

(defvar *input*)

(defun read-input (filename)
	(with-open-file (stream filename)
		(let ((lines (loop for line = (read-line stream nil)
											 while line
											 collect line)))
			(setf *input* (make-array (length lines) :initial-contents lines)))))

(defun get-map-val (row col)
	(aref (aref *input* row) (mod col (length (aref *input* 0)))))

(defun tree-p (row col)
	(eq #\# (get-map-val row col)))

(defun count-trees (right down)
	(loop for row from down upto (1- (length *input*)) by down
				for col from right by right
				counting (tree-p row col)))

;; part 1
(count-trees 3 1)

;; part 2
(apply #'* (loop for (right down) in '((1 1) (3 1) (5 1) (7 1) (1 2))
								 collecting (count-trees right down)))

(read-input "input")
