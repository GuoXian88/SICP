;;cube root

(define (cube-iter guess x)
    (if (good-enough? guess x)
        guess
        (cube-iter (improve guess x) x))
)

;只需要改improve就好了
(define (improve y x)
    (/ (+ (* 2 y) (/ x (square y))) 3)
)


;; 解答
 ;; ex 1.8. Based on the solution of ex 1.7. 
  
 (define (square x) (* x x)) 
    
   (define (cube-root-iter guess prev-guess x) 
     (if (good-enough? guess prev-guess) 
         guess 
         (cube-root-iter (improve guess x) guess x))) 
    
   (define (improve guess x) 
     (average3 (/ x (square guess)) guess guess)) 
    
   (define (average3 x y z) 
     (/ (+ x y z) 3)) 
    
   ;; Stop when the difference is less than 1/1000th of the guess 
   (define (good-enough? guess prev-guess) 
     (< (abs (- guess prev-guess)) (abs (* guess 0.001)))) 
    
   (define (cube-root x) 
     (cube-root-iter 1.0 0.0 x)) 

 ;; this fails for -2 due to zero division :( 
;;(define (cube-root x) 
 ;;  ((if (< x 0) - +)(cube-root-iter (improve 1.0 (abs x)) 1 (abs x)))) 

 (define (cube-root x) 
    (cube-root-iter 1.0 x)) 
   
  (define (cube-root-iter guess x) 
    (if (good-enough? guess x) 
        guess 
        (cube-root-iter (improve guess x) 
                        x))) 
   
  (define (good-enough? guess x) 
    (< (relative-error guess (improve guess x)) error-threshold)) 
   
  (define (relative-error estimate reference) 
    (/ (abs (- estimate reference)) reference)) 
   
  (define (improve guess x) 
    (average3 (/ x (square guess)) guess guess)) 
   
  (define (average3 x y z) 
    (/ (+ x y z) 3)) 
   
  (define error-threshold 0.01)

;;
  (define (square x) (* x x)) 
    (define (cube x) (* x x x)) 
     
    (define (good-enough? guess x improve) 
      (< (abs (- (improve guess x) guess)) 
         (abs (* guess 0.001)))) 
     
    (define (root-iter guess x improve) 
      (if (good-enough? guess x improve) 
          guess 
          (root-iter (improve guess x) x improve))) 
     
    (define (sqrt-improve guess x) 
      (/ (+ guess (/ x guess)) 2)) 
     
    (define (cbrt-improve guess x) 
      (/ (+ (/ x (square guess)) 
            (* 2 guess)) 
         3)) 
     
    (define (sqrt x) 
      (root-iter 1.0 x sqrt-improve)) 
     
    (define (cbrt x) 
      (root-iter 1.0 x cbrt-improve)) 