#!/usr/bin/env -S clesh_script.sh -s

; (require :import-package-1)
; (import 'clesh:script)
(in-package :cl-user)


(defun repl-main (exe &rest args)
  (declare (ignore exe))
  (pprint args)
  )
(defun cli-main (exe &rest args)
  (declare (ignore exe))
  (pprint args))

(defun main (&rest args)
  (destructuring-bind (&optional exe &rest cli-args) (and (find-package "SB-EXT") sb-ext:*posix-argv*)
    (if cli-args
      (apply #'cli-main cli-args)
      (apply #'repl-main args))))

(main)


