#lang racket

#|

When running under Racket, this file gets used in preference
over "compat.scm". We use Racket versions of the required definitions
where available.

|#

(define-syntax-rule (re-export-at (phase spec) ...)
  (begin
    (require (for-meta phase (only-meta-in 0 spec)) ...)
    (provide (for-meta phase (all-from-out spec)) ...)))

;; R6RS APIs
(re-export-at (2 rnrs))

;; Rackety things like #%app and #%datum
(re-export-at (2 r6rs/private/prelims))

;; somewhat non-standard Scheme, mostly from Racket
(re-export-at (-1 "compat-lib.rkt")
              (0 "compat-lib.rkt")
              (1 "compat-lib.rkt")
              (2 "compat-lib.rkt"))
