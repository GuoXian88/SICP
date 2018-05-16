;self
(define (count-change amount)
    (cc amount 5)
)

(define (cc amount kinds-of-coins)
    (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount (- kinds-of-coins 1))
                (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)
            )
        )
    )
)

(define (first-denomination kinds-of-coins)
    (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)
    )
)

;rewrite cc
(define (cc amount coin-values)
    (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else 
            (+ (cc amount (except-first-denomination coin-values))
                (cc (- amount (first-denomination coin-values)) coin-values)
            )
        )
    )
)

(define (except-first-denomination coin-values)
    (if (null? coin-values)
        nil
        (cdr coin-values)
    )
)


(define (first-denomination coin-values)
    (car coin-values)
)

(define (no-more? coin-values)
    (= (car coin-values) nil)
)

;answer

;; Counting change. 
  
 ;; Helper methods, could define them in cc too: 
 (define (first-denomination denominations) (car denominations)) 
 (define (except-first-denom denominations) (cdr denominations)) 
 (define (no-more? denominations) (null? denominations)) 
  
 (define (cc amount denominations) 
   (cond  
    ;; If there's no change left, we have a solution 
    ((= amount 0) 1) 
     
    ;; If we're gone -ve amount, or there are no more kinds of coins 
    ;; to play with, we don't have a solution. 
    ((or (< amount 0) (no-more? denominations)) 0) 
     
    (else 
     ;; number of ways to make change without the current coin type 
     ;; plus the number of ways after subtracting the amount of the 
     ;; current coin. 
     (+ (cc amount (except-first-denom denominations)) 
        (cc (- amount  
               (first-denomination denominations))  
            denominations))))) 
  
  
 (cc 100 (list 50 25 10 5 1)) 
 ;; 292 
  
 (cc 100 (list 100 50 20 10 5 2 1 0.5)) 
 ;; 104561 ... wow. 
