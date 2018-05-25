;self 写equal?

(define (equal? s1 s2)
    
    (for-each (lambda (i1)

    
        )

    )
)

;answer


 (define (equal? list1 list2) 
   (cond ((and (not (pair? list1)) (not (pair? list2))) 
          (eq? list1 list2)) 
         ((and (pair? list1) (pair? list2)) 
          (and (equal? (car list1) (car list2)) (equal? (cdr list1) (cdr list2)))) 
         (else false))) 
  
 (equal? '(1 2 3 (4 5) 6) '(1 2 3 (4 5) 6)) 
 ;Value: #t 
  
 (equal? '(1 2 3 (4 5) 6) '(1 2 3 (4 5 7) 6)) 
 ;Value: #f 