;;;; day4.lisp

(in-package #:day4)

(defvar *input*)

(defun read-input (filename)
  (setf *input*
        (with-open-file (stream filename)
          (loop for line = (read-line stream nil)
                while line
                collect line into lines
                finally (return
                          (mapcar (lambda (list)
                                    (mapcar (lambda (item) (let ((pair (split-sequence:split-sequence #\: item)))
                                                             (cons (intern (string-upcase (first pair))) (second pair))))
                                            list))
                                  (mapcar (lambda (string) (split-sequence:split-sequence #\  string))
                                          (mapcar (lambda (block)
                                                    (format nil "~{~A~^ ~}" block))
                                                  (split-sequence:split-sequence ""  lines :test #'string=)))))))))

(defparameter *needed* '(BYR IYR EYR HGT HCL ECL PID))

(defun valid-passport-p (passport)
  (not (set-difference *needed* (mapcar #'car passport))))

(loop for p in *input* counting (valid-passport-p p))
