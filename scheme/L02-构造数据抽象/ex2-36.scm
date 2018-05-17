;self 简单但是很难想到
(define (accumulate-n op init seqs)
    (if (null? (car seqs)
        nil
        (cons (accumulate op init (map car seqs))
                (accumulate-n op init (map cdr seqs))
        )
    )
)

;answer

(define (select-cars sequence) 
   (map car sequence)) 
  
 (define (select-cdrs sequence) 
   (map cdr sequence)) 
  
 ;; Test 
 (define t (list (list 1 2 3) (list 40 50 60) (list 700 800 900))) 
 (select-cars t) 
 (select-cdrs t) 
  
  
 ;; Accumulates the result of the first and the already-accumulated 
 ;; rest. 
 (define (accumulate op initial sequence) 
   (if (null? sequence) 
       initial 
       (op (car sequence) 
           (accumulate op initial (cdr sequence))))) 
  
  
 ;; accumulate-n 
 (define (accumulate-n op init sequence) 
   (define nil '()) 
   (if (null? (car sequence)) 
       nil 
       (cons (accumulate op init (map car sequence)) 
             (accumulate-n op init (map cdr sequence))))) 
  
 ;; Usage: 
 (accumulate-n + 0 t) 