;self solution


;answer
 ;; New definition: Division by interval spanning 0 should fail. 
 (define (div-interval x y) 
   (if (>= 0 (* (lower-bound y) (upper-bound y))) 
       (error "Division error (interval spans 0)" y) 
       (mul-interval x  
                     (make-interval (/ 1. (upper-bound y)) 
                                    (/ 1. (lower-bound y)))))) 
  
 (define span-0 (make-interval -1 1)) 
 (print-interval "i/j" (div-interval i j)) 
 (print-interval "i/span-0" (div-interval i span-0)) 