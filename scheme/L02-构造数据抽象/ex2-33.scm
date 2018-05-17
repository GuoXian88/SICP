;self
(define (map p sequences)
    (accumulate (lambda (x y) (+ x y)) nil sequences)
)


(define (append seq1 seq2)
    (accumulate cons seq1 seq2)
)

(define (length sequences)
    (accumulate (lambda (x) 1) 0 sequences)
)


;answer


;; Ex 2.33 
  
 ;; Accumulates the result of the first and the already-accumulated 
 ;; rest. 
 (define (accumulate op initial sequence) 
   (if (null? sequence) 
       initial 
       (op (car sequence) 
           (accumulate op initial (cdr sequence))))) 
  
  
 (define nil '())  ;; stupid environment ... 
  
 ;; a. map 
  
 (define (my-map proc sequence) 
   (accumulate (lambda (first already-accumulated) 
                 (cons (proc first) already-accumulated)) 
               nil 
               sequence)) 
  
 ;; Test: 
  
 (my-map square (list)) 
 (my-map square (list 1 2 3 4)) 
  
  
 ;; b. append 
  
 (define (my-append list1 list2) 
   (accumulate cons 
               list2 
               list1)) 
  
 ;; Test: 
  
 (append (list 1 2 3) (list 4 5 6))  ;; checking order. 
 (my-append (list 1 2 3) (list 4 5 6)) 
  
  
 ;; c. length 
  
 (define (my-length sequence) 
   (accumulate (lambda (first already-acc) 
                 (+ 1 already-acc)) 
               0 
               sequence)) 
  
 ;; Test: 
 (length (list 1 2 3 (list 4 5))) 
 (my-length (list 1 2 3 (list 4 5))) 