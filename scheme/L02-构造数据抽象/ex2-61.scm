;self

;这个可以用分治算法

(define (adjoin-set x set)
    (cond ((< x (car set)) (cons x set))
        ((> x (car set)) ((cons (car set) (adjoin-set x (cdr set)))))
        (else set)
    )
)

;answer

 (define (adjoin-set x set) 
   (cond ((null? set) (list x)) 
         ((= x (car set)) set) 
         ((< x (car set)) (cons x set)) 
         (else (cons (car set) (adjoin-set x (cdr set)))))) 