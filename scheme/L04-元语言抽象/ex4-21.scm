;self


;answer

;; a 
  (lambda (n)  
    ((lambda (fib) 
       (fib fib n)) 
     (lambda (f n) 
       (cond ((= n 0) 0) 
             ((= n 1) 1) 
             (else (+ (f f (- n 2)) (f f (- n 1)))))))) 
  
 ;; b. filling the box as sequence: 
 ev? od? (- n 1) 
 ev? od? (- n 1) 

 