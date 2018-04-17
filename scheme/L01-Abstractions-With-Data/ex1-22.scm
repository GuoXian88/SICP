(define (time-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (runtime))
)

(define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime (- (runtime) start-time))
    )
)

(define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time)
)


 (define (search-for-primes first last) 
   (define (search-iter cur last) 
     (if (<= cur last) (timed-prime-test cur)) 
     (if (<= cur last) (search-iter (+ cur 2) last))) 
   (search-iter (if (even? first) (+ first 1) first) 
                (if (even? last) (- last 1) last))) 


;basic operations 
 (define (square x) 
     (* x x)) 
 (define (divides? a b) 
     (= (remainder b a) 0)) 
 (define (even? n) 
   (= (remainder n 2) 0)) 
 ;smallest divisor computation 
 (define (smallest-divisor n) 
     (define (find-divisor n test) 
       (cond ((> (square test) n) n) 
             ((divides? test n) test) 
             (else (find-divisor n (+ test 1))))) 
     (find-divisor n 2)) 
 ;primality check 
 (define (prime? n) 
     (= n (smallest-divisor n))) 
 ;check primality of consecutive odd integers in some range 
 ;time&primality test 
 ;drRacket has no (runtime) variable; had to substitute it with (current-milliseconds) which is basically same 
 (define (runtime) 
     (current-milliseconds)) 
 (define (timed-prime-test n) 
     (start-prime-test n (runtime))) 
 (define (start-prime-test n start-time) 
     (if (prime? n) 
         (report-prime n (- (runtime) start-time)) 
         #f)) 
 (define (report-prime n elapsed-time) 
     (display n) 
     (display "***") 
     (display elapsed-time) 
     (newline)) 
 ;search counter 
 (define (search-for-primes n counter) 
   (if (even? n) 
       (s-f-p (+ n 1) counter) 
       (s-f-p n counter))) 
 ;it's important to pay attention to the fact that predicate of the first 'if' here calls (timed-prime-test n) which in case of #t  computes into two procedures - (report-prime n (elapsed-time)) and 'then' case of the first 'if'.  
 (define (s-f-p n counter) 
     (if (> counter 0) 
       (if (timed-prime-test n) 
           (s-f-p (+ n 2) (- counter 1)) 
           (s-f-p (+ n 2) counter)) 
       "COMPUTATION COMPLETE")) 
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

;search_for_primes 奇数 in an range (a, b)

(define (odd? n)
  (not (= (remainder n 2) 0)))


(define (search_for_primes a b step)
    (if (odd? a)
        (timed-prime-test a)
        (search_for_primes (+ a 1) b step)
    )
    (if (< (+ a step) b)
        (search_for_primes (+ a step) b step)
    )
)


(search_for_primes 1000 10000 2)


;solution
;; ex 1.22 
  
(define (square x) (* x x)) 
  
    (define (smallest-divisor n) 
      (find-divisor n 2)) 
     
    (define (find-divisor n test-divisor) 
      (cond ((> (square test-divisor) n) n) 
            ((divides? test-divisor n) test-divisor) 
            (else (find-divisor n (+ test-divisor 1))))) 
     
    (define (divides? a b) 
      (= (remainder b a) 0)) 
     
    (define (prime? n) 
      (= n (smallest-divisor n))) 
     
    (define (timed-prime-test n) 
      (start-prime-test n (runtime))) 
     
    (define (start-prime-test n start-time) 
      (if (prime? n) 
          (report-prime n (- (runtime) start-time)))) 
     
    (define (report-prime n elapsed-time) 
      (newline) 
      (display n) 
      (display " *** ") 
      (display elapsed-time)) 
     
    (define (search-for-primes first last) 
      (define (search-iter cur last) 
        (if (<= cur last) (timed-prime-test cur)) 
        (if (<= cur last) (search-iter (+ cur 2) last))) 
      (search-iter (if (even? first) (+ first 1) first) 
                   (if (even? last) (- last 1) last))) 
     
    (search-for-primes 1000 1019)       ; 1e3 
    (search-for-primes 10000 10037)     ; 1e4 
    (search-for-primes 100000 100043)   ; 1e5 
    (search-for-primes 1000000 1000037) ; 1e6 
     
    ; As of 2008, computers have become too fast to appreciate the time 
    ; required to test the primality of such small numbers. 
    ; To get meaningful results, we should perform the test with numbers 
    ; greater by, say, a factor 1e6. 
    (newline) 
    (search-for-primes 1000000000 1000000021)       ; 1e9 
    (search-for-primes 10000000000 10000000061)     ; 1e10 
    (search-for-primes 100000000000 100000000057)   ; 1e11 
    (search-for-primes 1000000000000 1000000000063) ; 1e12 

