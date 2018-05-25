;self

(define (prime-sum-pairs n)
    (map make-pair-sum 
        (filter prime-sum?
            (flatmap
                (lambda (i)
                    (map (lambda ((j) (list i j))))
                )
                (enumerate-interval 1 (- i 1))
            )
        )
        (enumerate-interval 1 n)
    )
)


(define (unique-pairs n)
    (flatmap
        (lambda (i)
            (map (lambda ((j) (list i j))
                (enumerate-interval 1 (- i 1))
            ))
        )
        (enumerate-interval 1 n)
    )    
)


;answer


 ;; The answer ... it's just the top of page 123, pulled into a new 
 ;; function (with flatmap): 
 (define (unique-pairs n) 
   (flatmap (lambda (i)  
              (map (lambda (j) (list i j)) 
                   (enumerate-interval 1 (- i 1)))) 
            (enumerate-interval 1 n))) 

 (define (prime-sum-pairs n) 
   (map make-sum-pair 
        (filter prime-sum? (unique-pairs n)))) 

