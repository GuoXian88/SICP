;self solution
(define (sub-interval x y)
    (cons 
        (make-interval 
            (min (lower-bound x) (lower-bound y))
            (max ((lower-bound x) (lower-bound y)))
        )
        (make-interval
            (min (upper-bound x) (upper-bound y))
            (max (upper-bound x) (upper-bound y))
        )
    )
)

;answer
;; The max and min can be supplied to the constructor in any order. 
 (define (make-interval a b) (cons a b)) 
 (define (upper-bound interval) (max (car interval) (cdr interval))) 
 (define (lower-bound interval) (min (car interval) (cdr interval))) 
  
 ;; The minimum value would be the smallest possible value 
 ;; of the first minus the largest of the second.  The maximum would be 
 ;; the largest of the first minus the smallest of the second. 
 (define (sub-interval x y) 
   (make-interval (- (lower-bound x) (upper-bound y)) 
                  (- (upper-bound x) (lower-bound y)))) 
  
 (define (display-interval i) 
   (newline) 
   (display "[") 
   (display (lower-bound i)) 
   (display ",") 
   (display (upper-bound i)) 
   (display "]")) 
  
 ;; Usage 
 (define i (make-interval 2 7)) 
 (define j (make-interval 8 3)) 
  
 (display-interval i) 
 (display-interval (sub-interval i j)) 
 (display-interval (sub-interval j i)) 
