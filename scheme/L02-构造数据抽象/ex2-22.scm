;self
(define (square-list items)
    (define (iter things answer)
        (if (null? items)
            answer
            (iter (cdr things)
                (cons (square (car things)) answer)
            )
        )
    )
)
;要用append才行, 这样cons会产生嵌套的list


;answer

(define nil '()) 
  
 (define (square-list items) 
   (define (iter things answer) 
     (if (null? things) 
         answer 
         (iter (cdr things) 
               (cons (square (car things)) answer)))) 
   (iter items nil)) 
  
 (square-list (list 1 2 3 4)) 
  
 ;; The above doesn't work because it conses the last item from the 
 ;; front of the list to the answer, then gets the next item from the 
 ;; front, etc. 
  
 (define (square-list items) 
   (define (iter things answer) 
     (if (null? things) 
         answer 
         (iter (cdr things) 
               (cons answer (square (car things)))))) 
   (iter items nil)) 
  
 (square-list (list 1 2 3 4)) 

 ;; This new-and-not-improved version conses the answer to the squared 
 ;; value, but the answer is a list, so you'll end up with (list (list 
 ;; ...) lastest-square). 