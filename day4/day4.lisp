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

(read-input)
(loop for p in *input* counting (valid-passport-p p))

;; part2

(defstruct passport
  byr
  iyr
  eyr
  hgt
  hcl
  ecl
  pid
  cid
  )

(defun read-input2 (file-name)
  (loop for entry in (read-input file-name)
        if (valid-passport-p entry)
					collect
					(let ((passport (make-passport)))
						(loop for part in entry do
							(setf (slot-value passport (car part)) (cdr part))
									finally (return passport)))))



(defun valid-passport-2-p (passport)
	(and
	 (cl-ppcre:scan "^\\d\\d\\d\\d$" (passport-byr passport))
	 (>= (read-from-string (passport-byr passport)) 1920)
	 (<= (read-from-string (passport-byr passport)) 2002)
	 (cl-ppcre:scan "^\\d\\d\\d\\d$" (passport-iyr passport))
	 (>= (read-from-string (passport-iyr passport)) 2010)
	 (<= (read-from-string (passport-iyr passport)) 2020)
	 (cl-ppcre:scan "^\\d\\d\\d\\d$" (passport-eyr passport))
	 (>= (read-from-string (passport-eyr passport)) 2020)
	 (<= (read-from-string (passport-eyr passport)) 2030)
	 (or (multiple-value-bind (line parts)
					 (cl-ppcre:scan-to-strings "^(\\d+)cm$" (passport-hgt passport))
				 (and
					line
					(>= (read-from-string (aref parts 0)) 150)
					(<= (read-from-string (aref parts 0)) 193))
				 )
			 (multiple-value-bind (line parts)
					 (cl-ppcre:scan-to-strings "^(\\d+)in$" (passport-hgt passport))
				 (and
					line
					(>= (read-from-string (aref parts 0)) 59)
					(<= (read-from-string (aref parts 0)) 76))))
	 (cl-ppcre:scan "^#[0-9a-f]{6}$" (passport-hcl passport))
	 (cl-ppcre:scan "^amb|blu|brn|gry|grn|hzl|oth$" (passport-ecl passport))
	 (cl-ppcre:scan "^(\\d){9}$" (passport-pid passport))))

(loop for passport in (read-input2 "input") counting (valid-passport-2-p passport))

