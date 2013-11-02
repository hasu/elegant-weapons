(library (elegant-weapons define-match)
  (export define-match)
  (import (rnrs))
  
;; From http://scheme.com/csug8/syntax.html#./syntax:s11
(define-syntax with-implicit
  (syntax-rules ()
    [(_ (tid id ...) b1 b2 ...)
     (with-syntax ([id (datum->syntax #'tid 'id)] ...)
       b1 b2 ...)]))

;; This abstracts away most of the boilerplate for writing
;; match-based transformations. A little unsafe.
;; Stipulation: make sure the match macro is in the environment
;; everywhere this macro is used.
(define-syntax define-match
  (lambda (x)
    (syntax-case x ()
      ((k (name args ...) clauses ...)
       (with-implicit (k match)
                      #'(define (name args ...)
                          (lambda (arg)
                            (match arg
                              clauses ...
                              (,else
                               (error 'name "Unrecognized item" else)))))))
      ((k name clauses ...)
       (with-implicit (k match)
                      #'(define name
                          (lambda (arg)
                            (match arg
                              clauses ...
                              (,else
                               (error 'name "Unrecognized item" else))))))))))
  
  )
