;self solution
(define (make-interval a b) (cons a b))

(define (upper-bound inter) (cdr inter))
(define (lower-bound inter) (car inter))

;answer

;; ex 2.7 顺序是无序的
 (define (make-interval a b) (cons a b)) 
 (define (upper-bound interval) (max (car interval) (cdr interval))) 
 (define (lower-bound interval) (min (car interval) (cdr interval))) 
  
 ;; Usage 
 (define i (make-interval 2 7)) 
 (upper-bound i) 
 (lower-bound i) 
  
 (define j (make-interval 8 3)) 
 (upper-bound j) 
 (lower-bound j) 

