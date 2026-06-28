#!/usr/bin/env -S clesh_script.sh -s

; (require :import-package-1)
; (import 'clesh:script)


(defun main (&rest args)
  (pprint args)
  )

   

(apply #'main (cdr sb-ext:*posix-argv*))

   
