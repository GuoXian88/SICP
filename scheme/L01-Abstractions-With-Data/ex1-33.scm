;self solution
(define (filtered-accumulate filter combiner null-value term a next b)
    (if (> a b)
        null-value
        (if (filter (term a))
            (combiner (term a) (accumulate combiner null-value term (next a) next b))
            (accumulate combiner null-value term (next a) next b)
        )
    )
)


(filtered-accumulate prime? add 0 identity a inc b)
(filtered-accumulate gcd? multiply 0 identity a inc b)

;answer
(define (smallest-div n) 
    (define (divides? a b) 
      (= 0 (remainder b a))) 
    (define (find-div n test) 
       (cond ((> (sq test) n) n) ((divides? test n) test) 
             (else (find-div n (+ test 1))))) 
    (find-div n 2)) 
  
(define (prime? n) 
    (if (= n 1) false (= n (smallest-div n)))) 

(define (filtered-accumulate combiner null-value term a next b filter) 
  (if (> a b) null-value 
      (if (filter a) 
          (combiner (term a) (filtered-accumulate combiner null-value term (next a) next b filter)) 
          (combiner null-value (filtered-accumulate combiner null-value term (next a) next b filter)))))


;iterative
 (define (filtered-accumulate combiner null-value term a next b filter) 
   (define (iter a result) 
     (cond ((> a b) result) 
           ((filter a) (iter (next a) (combiner result (term a)))) 
           (else (iter (next a) result)))) 
   (iter a null-value)) 


(define (gcd m n) 
   (cond ((< m n) (gcd n m)) 
         ((= n 0) m) 
         (else (gcd n (remainder m n))))) 
  
 (define (relative-prime? m n) 
 (= (gcd m n) 1)) 
  
 (define (product-of-relative-primes n) 
   (define (filter x) 
     (relative-prime? x n)) 
 (filtered-accumulate * 1 identity 1 inc n filter)) 
 