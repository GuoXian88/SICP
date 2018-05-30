;self


(define (make-accumulator res)
    (define (add num)
        (begin (set! res (+ num res)) res)
    )

    (define (dispatch m)
        (cond ((eq? m ' ) add)
            (else (error "Unsupport operation!" m))
        )
    )
    dispatch
)



;answer

(define (make-accumulator initial-value) 
   (let ((sum initial-value)) 
     (lambda (n) 
       (set! sum (+ sum n)) 
       sum)))


 (define (make-accumulator acc) 
   (lambda (x) 
     (set! acc (+ x acc)) 
     acc)) 