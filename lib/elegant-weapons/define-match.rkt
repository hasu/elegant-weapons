#lang racket

#|

For define-match.scm, Racket gives an error

k: pattern variable cannot be used outside of a template
  at: k
  in: (k match)

and we instead use this implementation, which hopefully is close
enough to having the same semantics.

|#

(provide define-match)

(require (only-in "match.rkt" [match my-match]))

(define-syntax-rule
  (sub-define-match name sig clauses ...)
  (define sig
    (lambda (expr)
      (my-match expr
        clauses ...
        (,else
         (error 'name "Unrecognized item" else))))))

(define-syntax (define-match stx)
  (syntax-case stx ()
    ((_ (name args ...) clauses ...)
     (identifier? #'name)
     #'(sub-define-match name (name args ...) clauses ...))
    ((_ name clauses ...)
     (identifier? #'name)
     #'(sub-define-match name name clauses ...))))
