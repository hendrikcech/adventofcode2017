(setf my-array (make-array '(2048)))
(defvar counter 0)
(defvar stepCounter 0)
(defvar pointer 0)
(defvar curValue 0)


(defun verbose-sum (x y)
  "Sum any two numbers after printing a message."
  (format t "Summing ~d and ~d.~%" x y)
  (+ x y))

(defun makeArrayFromFile (path arrayArg)
  "Makes array from file"
  * (with-open-file (stream path)
      (do ((line (read-line stream nil)
                 (read-line stream nil)))
          ((null line))
        (setf (aref arrayArg counter) (parse-integer line))
        (setq counter (+ counter 1))
        ))
  )

(makeArrayFromFile "input.txt" my-array)
(print my-array)
(print counter)

(loop while (< pointer counter) do
  (setq curValue (aref my-array pointer))
  (if (> curValue 2)
    (setf (aref my-array pointer) (+ curValue 1))
    (setf (aref my-array pointer) (+ curValue 1)))

  (setq pointer (+ curValue pointer))
  (setq stepCounter (+ stepCounter 1))
)

(print stepCounter)
