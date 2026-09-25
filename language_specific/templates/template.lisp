#!/usr/bin/env -S clesh_script.sh -s

; (require :import-package-1)
; (import 'clesh:script)
(in-package :cl-user)


(defun cli-main (exe &rest args)
  (declare (ignore exe))
  (pprint args)
  )

(defun main (&rest args)
  (let ((args (and (find-package "SB-EXT") sb-ext:*posix-argv*)))
    (when args
      (apply #'cli-main args))))

(main)

   
