;self
(define (fold-left op initial sequence)
    (define (iter result rest)
        (if (null? rest)
            result
            (iter (op result (car rest)) (cdr rest))
        )
    )
    (iter initial sequence)
)


;answer
;; Accumulates the result of the first and the already-accumulated 
 ;; rest. 
 (define (accumulate op initial sequence) 
   (if (null? sequence) 
       initial 
       (op (car sequence) 
           (accumulate op initial (cdr sequence))))) 
  
 (define (fold-right op initial sequence) 
   (accumulate op initial sequence)) 
  
  
 (define (fold-left op initial sequence) 
   (define (iter result rest) 
     (if (null? rest) 
         result 
         (iter (op result (car rest)) 
               (cdr rest)))) 
   (iter initial sequence)) 


 (fold-right / 1 (list 1 2 3))
  = (/ 1 (/ 2 (/ 3 1)))
  = (/ 1 2/3)
  = 3/2

   (fold-left / 1 (list 1 2 3))
  = (/ (/ (/ 1 1) 2) 3)
  = (/ (/ 1 2) 3)
  = (/ 1/2 3)
  = 1/6
  
