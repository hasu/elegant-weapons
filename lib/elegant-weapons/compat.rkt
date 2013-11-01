#lang racket

#|

When running under Racket, this file gets used in preference
over "compat.scm". We use Racket versions of the required definitions
where available.

|#

(provide add1 sub1 syntax-error make-parameter parameterize
         last-pair make-list void)
  
;; Has the same interface as Scheme 'error', namely (syntax-error who
;; msg irritant ...), where 'who' is (or/c string? symbol? #f) and
;; 'msg' is a string, and 'irritants' are any objects. It seems that
;; in practice an identifier? is also passed as 'who' in places.
(define (syntax-error who msg . irritant)
  (error
   (cond
    ((symbol? who) who)
    ((identifier? who) (syntax-e who))
    ((string? who) (string->symbol who))
    (else #f))
   (if (null? irritant)
       msg
       (format "~a: ~s" msg irritant))))
