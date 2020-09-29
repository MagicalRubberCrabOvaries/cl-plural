;;;; plural.lisp

(in-package #:plural)

(proclaim '(optimise))
(proclaim '(inline plural))


#| MACRO MAPPING

Macros used for mapping macros as one would
map a function. |#


;;; Map macros!
(defmacro mapmac (mac lambda-lists)
  "MAPCAR a macro over a list of lambda-lists."
  `(mapcar #'(lambda (lambda-list)
               `(,',mac ,@(if (listp lambda-list)
                              lambda-list
                              (list lambda-list))))
           ,lambda-lists))


;;; Map a lambda-list to multiple function or macro
;;;   calls and return results as a list.
(defmacro mapargs (lambda-list fns)
  "MAPCAR but one lambda-list mapped to many functions."
  `(mapcar #'(lambda (fn)
               `(,fn ,,@lambda-list))
           ,fns))


;;; PLURALIZATION

#| Create "plural" versions of a macro or function which maps
over &rest lambda-lists and executes each sequentially. 
Intended for use for macros such as DEFVAR. 

For cases where the macro is meant to gather into a list, 
use MAPMAC instead. |#


;;; Pluralize the symbol name.
;;;   For use with the pluralize macro.
(defun plural (sym)
  "Generate a pluralized symbol."
  (let* ((sym-string (symbol-name sym))
         (len        (length sym-string)))
    (intern (if (string= "S" (subseq sym-string (1- len) len))
                (concatenate 'string sym-string "ES")
                (concatenate 'string sym-string "S")))))

(defmacro defplural (mac)
  "Create a variant fn which maps over lambda-lists*."
  (let ((pluralized (plural mac)))
    `(defmacro ,pluralized (&rest lambda-lists)
       `(progn ,@(mapmac ,mac lambda-lists)))))


(defmacro defplurals (&rest macs)
  "Apply DEFPLURAL to MACS*"
  `(progn ,@(mapmac defplural macs)))
