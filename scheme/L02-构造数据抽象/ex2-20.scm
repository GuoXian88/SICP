;self
(define (same-parity items)
    (define (parity? item)
        (let (first-even? (even? (car items))) 
            (if (first-even?)
                (even? item)
                (not (even? item))
            )
        )
    )

    (define (same-parity-iter items res)
        (if(null? items)
            res
            (if (parity? (car items))
                (same-parity-iter (cdr items) (cons ((car items) res)))
                (same-parity-iter (cdr items) res)
            )
        )
    )

    (same-parity-iter items nil)
)

;answer
(define (same-parity first . rest) 
   (define (same-parity-iter source dist remainder-val) 
     (if (null? source) 
         dist 
         (same-parity-iter (cdr source) 
                           (if (= (remainder (car source) 2) remainder-val) 
                               (append dist (list (car source))) 
                               dist) 
                           remainder-val))) 
    
   (same-parity-iter rest (list first) (remainder first 2))) 