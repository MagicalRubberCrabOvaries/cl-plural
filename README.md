# cl-plural

Common Lisp utilities to map macros and reduce repetitive macro calls. 

## MAPMAC

MAPMAC behaves as MAPCAR except that it accepts macro arguments. For the trivial macro example TWIN-PAIR which takes any symbol and returns a cons of the symbol with itself, mapmac would behave as follows:

```lisp
(defmacro twin-pair (s)                                       ; This macro takes any symbol 'S' 
    "Return a CONS cell where both CAR and CDR are A."        ; and returns (A . A)
    `(',s . ',s))                                             ; * (twinpair banana)
                                                              ; -> (BANANA . BANANA)
                                                              
* (mapmac twin-pair '(a b c))
-> ((A . A) (B . B) (C . C))
```

## MAPARGS

MAPARG instead maps one lambda list to many functions or macros. 

```lisp
* (mapargs '(1) integerp evenp realp)
-> (T NIL T)
```

## DEFPLURAL

DEFPLURAL creates a shortcut for mapping macros and executing them in a block. This eliminates the need to, for the sake of an example, write defvar six times to define six variables. Note, any pluralized function or macro will be expand into a series of executions in a BLOCK. For more generic mapping, see MAPMAC.

```lisp
* (defplural defvar)
-> DEFVARS

* (defvars (*a* 0)
           (*b* 1)
           (*c* 2))
-> *C*

* *a*
-> 0

* *b*
-> 1

* *c*
-> 2(

* (+ *a* *b* *c*)
-> 3
```

## DEFPLURALS

The pluralized version of DEFPLURAL.

```lisp
* (defplurals defvar defparameter defconstant)
-> DEFCONSTANTS

;;; See above for behavior of pluralized functions and macros.
```