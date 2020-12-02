;;;; day1.lisp

(in-package #:day1)

(defun read-input(file-name)
	(let ((list (with-open-file (in file-name :direction :input)
								(loop :for number := (read in nil)
											:while number
											:collect number))))
		(make-array (length list) :initial-contents list)))

(defvar *input* (read-input "input"))

(defun find-pair-that-sums (target numbers)
	(loop for i from 0 upto (- (length numbers) 2)
				do (loop for j from (1+ i) upto (- (length numbers) 1)
								 do
										(when (= target
														 (+ (aref numbers i) (aref numbers j))
														 )
											(return-from find-pair-that-sums (* (aref numbers i) (aref numbers j)))))))

(defun find-trio-that-sums (target numbers)
	(loop for i from 0 upto (- (length numbers) 3)
				do (let ((pair-mult (find-pair-that-sums (- 2020 (aref numbers i))
																								 (subseq numbers (1+ i))
																								 )))
						 (when pair-mult
							 (return-from find-trio-that-sums (* (aref numbers i) pair-mult))))))

;; first part
(find-pair-that-sums 2020 *input*)

;; second part
(find-trio-that-sums 2020 *input*)
