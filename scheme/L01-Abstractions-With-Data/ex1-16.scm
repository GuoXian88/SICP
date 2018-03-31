;

(define (fast-exp-iter b n)
    (fast-exp-iter-helper b n a)
)
;an additional state variable a, and define the state transformation in such a way that the product a bn is unchanged from state to state. At the beginning of the process a is taken to be 1, and the answer is given by the value of a at the end of the process. In general, the technique of defining an invariant quantity that remains unchanged from state to state is a powerful way to think about the design of iterative algorithms.


(define (fast-exp-iter-helper b n a)
    (if (< n 1)
        a
        (fast-exp-iter-helper (square b) (/ n 2) (square b))
    )
)

; answer:
(define (fast-expt b n) 
   (define (iter a b n) 
     (cond ((= n 0) a) 
           ((even? n) (iter a (square b) (/ n 2))) 
           (else (iter (* a b) b (- n 1))))) 
   (iter 1 b n)) 
  
 (define (square x) (* x x)) 


(define (fast-expt b n) 
   (define (cube x) (* x x x)) 
   (define (fast-expt-iter b a counter) 
     (cond ((= counter 0) a) 
           ((= counter 1) (* a b)) 
           ((even? counter) (fast-expt-iter  
                              (square b) 
                              (* (square b) a) 
                              (- (/ counter 2) 1))) 
           (else (fast-expt-iter  
                   (square b)  
                   (* (cube b) a) 
                   (- (/ (- counter 1) 2) 1))))) 
   (fast-expt-iter b 1 n)) 