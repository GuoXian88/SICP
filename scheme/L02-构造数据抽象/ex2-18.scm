;self 错了
(define (reverse items)
    (if (null? car items)
        items
        (reverse (cons (cdr items) (car items)))
    )
)
;answer

;; ex 2.18, reverse. 果然还是要引入一个中间变量存储新的表
  
 ;; Note: nil isn't defined in my environment, using footnote from page 
 ;; 101. 
 (define nil '()) 
  
 (define (reverse items) 
   (define (iter items result) 
     (if (null? items) 
         result 
         (iter (cdr items) (cons (car items) result)))) 
  
   (iter items nil)) 
  
  
 ;; Usage 
 (reverse (list 1 2 3 4)) 
