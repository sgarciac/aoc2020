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


(read-input "input")
