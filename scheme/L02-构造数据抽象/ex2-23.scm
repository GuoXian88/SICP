;self
(define (for-each proc items)
    (if (null? item)
        nil
        (for-each proc (cdr items))
        (proc (car items))
    )
)

;answer
(define (for-each proc items) 
   (let ((items-cdr (cdr items))) 
     (proc (car items)) 
     (if (not (null? items-cdr)) 
         (for-each proc items-cdr) 
         true))) 
