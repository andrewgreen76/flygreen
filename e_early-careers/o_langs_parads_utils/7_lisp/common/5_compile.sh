sbcl --compile-file msg.lisp

#sbcl --load your_program.lisp --eval '(save-lisp-and-die "your_program.core")'
