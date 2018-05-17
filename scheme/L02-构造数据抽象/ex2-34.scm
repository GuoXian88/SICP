;self
(define (horner-eval x coefficiennt-sequence)
    (accumulate (lambda (this-coeff higher-terms) (+ this-coeff (* higher-terms x))) 0 coefficiennt-sequence)
)


;answer

(define (horner-eval x coefficient-sequence) 
   (accumulate (lambda (this-coeff higher-terms) 
                 (+ (* higher-terms x) this-coeff)) 
               0 
               coefficient-sequence)) 
  
 (horner-eval 2 (list 1 3 0 5 0 1)) 
 ⇒ 79 
 (horner-eval 2 (list 2 3 0 5 0 1)) ; Expect 1 greater than above. 
 ⇒ 80 
 (horner-eval 2 (list 2 3 0 5 0 2)) ; Expect 2⁵ = 32 greater than above. 
 ⇒ 112 