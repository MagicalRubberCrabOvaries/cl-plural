;;;; plural.asd

(asdf:defsystem #:cl-plural
  :description "Utility library for mapping macros."
  :author "MRCO <angryspacefungus@gmail.com>"
  :license "GPL 3.0"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
               (:file "plural" :depends-on ("package"))))
