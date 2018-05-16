;self
(define (last-pair items res)
    (if (null? car items)
        res
        (last-pair (cdr items) (cons (car items) nil))
    )
)
;answer

;; ex-2.17 这个真是妙
  
 (define (last-pair items) 
   (let ((rest (cdr items))) 
     (if (null? rest) 
         items 
         (last-pair rest)))) 
  
 ;; Testing 
 (last-pair (list 23 72 149 34)) ; (34) 