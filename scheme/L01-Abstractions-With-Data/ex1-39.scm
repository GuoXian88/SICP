;self solution
(define (tan-cf x k)
    (define (y l)
        (if (= l k))
        0
        (/ (square x) (- (- (* 2 l) 1) (y (+ l 1))))
    )

    (y 0)
)

;answer

(define (tan-cf x k) 
   (define (iter i result) 
     (if (= i 0) 
         result 
         (iter (-1+ i) 
               (/ (if (= i 1) x (square x)) 
                  (- (- (* 2 i) 1) 
                     result))))) 
   (iter k 0)) 