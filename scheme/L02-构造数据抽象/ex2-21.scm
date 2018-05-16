;self
(define (square-list items)
    (if(null? items)
        nil
        (cons (square (car items))
            (square-list (cdr items))
        )
    )
)

(define (square-list items)
    (map square items)
)
;answer
(define (square-list items) 
   (if (null? items) 
       items 
       (cons (square (car items)) (square-list (cdr items))))) 
  
 (square-list (list 1 2 3 4)) 
  
 (define (sq2 items) 
   (map (lambda (x) (square x)) items)) 
  
 (sq2 (list 1 2 3 4)) 