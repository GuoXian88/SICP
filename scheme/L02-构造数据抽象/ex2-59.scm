;self
(define (union-set set1 set2)
    (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set? (car set1) set2)
            (cons (car set1) (union-set (cdr set1) set2))
        )
        (else (union-set (cdr set1) set2))
    )
)



;answer
(define (union-set s1 s2) 
  
   (if (null? s1) 
     s2 
     (let 
       ((e (car s1))) 
  
       (union-set 
         (cdr s1) 
         (if (element-of-set? e s2) s2 (cons e s2)))))) 
  
 guile> (define element-of-set? member) 
 guile> (define odds '(1 3 5)) 
 guile> (define evens '(0 2 4 6)) 
  
 guile> (union-set '() '()) 
 () 
  
 guile> (union-set '() evens) 
 (0 2 4 6) 
  
 guile> (union-set evens evens) 
 (0 2 4 6) 
  
 guile> (union-set evens odds) 
 (6 4 2 0 1 3 5) 
  
 guile> (union-set odds evens) 
 (5 3 1 0 2 4 6) 
  
 guile> 