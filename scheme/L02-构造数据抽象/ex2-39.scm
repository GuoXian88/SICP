;self
(define (reverse sequence)
    (fold-right (lambda (x y) (cons (y x)) ) nil sequence)
)

(define (reverse sequence)
    (fold-left (lambda (x y) (cons (x y))) nil sequence)
)


;answer

(define (reverse-using-right items) 
   (fold-right (lambda (first already-reversed) 
                 (append already-reversed (list first))) 
               nil 
               items)) 
  
 (define (reverse-using-left items) 
   (fold-left (lambda (result first) (cons first result)) 
              nil 
              items)) 
  
 ;; Test 
 (define items (list 1 2 3 4 5)) 
 (reverse-using-right items) 
 (reverse-using-left items) 