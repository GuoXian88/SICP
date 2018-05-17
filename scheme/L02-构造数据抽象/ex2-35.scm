;self
(define (count-leaves t)
    (accumulate (lambda (sub-tree sum)
        (+ (car sub-tree) sum)
    ) 0 t)
)


;answer

 (define (count-leaves-recursive t) 
   (accumulate + 0 (map (lambda (node) 
                          (if (pair? node) 
                              (count-leaves-recursive node) 
                              1)) 
                        t))) 
  
 ;; Usage 
 (count-leaves-recursive tree) ;; => 7 