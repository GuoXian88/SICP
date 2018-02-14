;; Try (sqrt 1000000000000) [that's with 12 zeroes], then try (sqrt 10000000000000) [13 zeroes]. On my 64-bit intel machine, the 12 zeroes yields an answer almost immediately whereas the 13 zeroes enters an endless loop. The algorithm gets stuck because (improve guess x) keeps on yielding 4472135.954999579 but (good-enough? guess x) keeps returning #f.

;;绝对误差改成相对误差,如果数很小的话误差会相对很大

(define (good-enough? guess x)
    (< (abs(- (improve guess x) guess))
    (* guess .001))
)

;;Alternate version, which adds an "oldguess" variable to the main function. 
(define (sqrt-iter guess oldguess x) 
    (if (good-enough? guess oldguess) 
        guess 
        (sqrt-iter (improve guess x) guess 
                   x))) 
   
   
  (define (good-enough? guess oldguess) 
    (< (abs (- guess oldguess)) 
       (* guess 0.001))) 
   
  (define (sqrt x) 
    (sqrt-iter 1.0 2.0 x)) 


;;Figured out why the procedure hangs on 0. It hangs because when the guess reaches 0, the delta between guess and oldguess can never be less than (* guess 0.001) because that evaluates to 0. If you change the '<' operator to '<=', the procedure will properly evaluate 0.

;Another take on the good-enough? function 
  
(define (good-enough? guess x) 
    (< (/ (abs (- (square guess) x)) guess) (* guess 0.0001))) 

; A guess is good enough when: 
 ;    abs(improved-guess - original-guess) / original-guess < 0.001 
  
 (define (good-enough? guess x) 
    (< (abs (/ (- (improve guess x) guess) 
               guess)) 
       0.001)) 