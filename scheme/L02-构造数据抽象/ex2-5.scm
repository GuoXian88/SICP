;self solution


 (define (exp base n) 
   (define (iter x result) 
     ;; invariant: base^x * result is constant. 
     (if (= 0 x) 
         result 
         (iter (- x 1) (* base result)))) 
   (iter n 1)) 



(define (cons a b)
    (* (exp 2 a) (exp 3 b))
)

(define (car z)

)

; answer
 (define (count-0-remainder-divisions n divisor) 
   (define (iter try-exp) 
     (if (= 0 (remainder n (exp divisor try-exp))) 
         (iter (+ try-exp 1))  ;; Try another division. 
         (- try-exp 1))) 
  
   ;; We don't need to try 0 divisions, as that will obviously pass. 
   (iter 1)) 
  
  
 ;; cons, car, cdr 
 (define (my-cons a b) (* (exp 2 a) (exp 3 b))) 
 (define (my-car z) (count-0-remainder-divisions z 2)) 
 (define (my-cdr z) (count-0-remainder-divisions z 3)) 




 ;; Another way to define count-0-remainder-divisions 
  
 (define (divides? a b) 
   (= 0 (remainder b a))) 
  
 (define (count-0-remainder-divisions n divisor) 
   (define (iter x divisions) 
     (if (divides? divisor x) 
         (iter (/ x divisor) (+ divisions 1)) 
         divisions)) 
   (iter n 0)) 