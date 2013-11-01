#lang racket/base

#|

Note that Racket exports very few things from r6rs itself. From rnrs
it exports things at phase levels -1, 0, and 1. Here we get some phase
level 2 definitions exported, and these then do not
require (import (rnrs)), but are built-in to our language.

|#

(require (for-syntax racket/base racket/syntax))

(define-syntax (r6rs-export-for-meta stx)
  (syntax-case stx ()
    ((_ id-t ...)
     (let ()
       (define id-lst (syntax->list #'(id-t ...)))
       (define id-pairs
         (map (lambda (id)
                (cons id (generate-temporary id))) id-lst))
       #`(begin
           (require (for-meta 2 (only-meta-in 0 (only-in rnrs #,@(map (lambda (p) #`(#,(car p) #,(cdr p))) id-pairs)))))
           (provide (for-meta 2 (rename-out #,@(map (lambda (p) #`(#,(cdr p) #,(car p))) id-pairs)))))))))

(r6rs-export-for-meta syntax-rules)

(require r6rs)
(provide (all-from-out r6rs))
