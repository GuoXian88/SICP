;self
(define (union-set set1 set2)
    (let ((e1 (car set1))
            (e2 (car set2))
    )
    (cond (
        (= e1 e2)
        (union-set (cdr set1) set2)
    )
    (   (< e1 e2)
        (cons (car set1) (union-set (cdr set1) set2))
    )
    (   (< e2 e1)
        (cons (car set2) (union-set set1 (cdr set2)))
    )
    )
    
    )
)
;answer

(define (union-set set1 set2) 
   (cond  ((null? set1) set2) 
          ((null? set2) set1) 
          ((= (car set1) (car set2))  
           (cons (car set1) (union-set (cdr set1) (cdr set2)))) 
          ((< (car set1) (car set2))   
           (cons (car set1) (union-set (cdr set1) set2))) 
          (else  
           (cons (car set2) (union-set set1 (cdr set2)))))) 