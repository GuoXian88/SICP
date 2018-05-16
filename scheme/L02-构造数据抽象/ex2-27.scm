;self
 (define (reverse items) 
   (define (iter items result) 
     (if (null? items) 
         result 
         (iter (cdr items) (cons (car items) result))))

(define (deep-reverse items)
    (define (iter items result)
        (if (null? items)
            result
            (iter (cdr items) (cons (deep-reverse (car items)) result))
        )
    )
)
;answer
;; A value for testing. 
 (define x (list (list 1 2) (list 3 (list 4 5)))) 
  
 ;; My environment doesn't have nil. 
 (define nil '()) 
  
  
 ;; Here's reverse for reference: 
 (define (reverse items) 
   (define (rev-imp items result) 
     (if (null? items) 
         result 
         (rev-imp (cdr items) (cons (car items) result)))) 
   (rev-imp items nil)) 
  
 ;; Usage: 
 (reverse x) 
 ;; Deep reverse.  Same as reverse, but when adding the car to the 
 ;; result, need to check if the car is a list.  If so, deep reverse 
 ;; it. 
  
 ;; First try: 
 (define (deep-reverse items) 
   (define (deep-rev-imp items result) 
     (if (null? items) 
         result 
         (let ((first (car items))) 
           (deep-rev-imp (cdr items) 
                    (cons (if (not (pair? first)) 
                              first 
                              (deep-reverse first)) 
                          result))))) 
   (deep-rev-imp items nil)) 
  
 ;; Usage: 
 (deep-reverse x) 


  ;; Works, but it's a bit hard to read?  Refactoring: 
  
 (define (deep-reverse-2 items) 
   (define (deep-rev-if-required item) 
     (if (not (pair? item)) 
         item 
         (deep-reverse-2 item))) 
   (define (deep-rev-imp items result) 
     (if (null? items) 
         result 
         (deep-rev-imp (cdr items) 
                       (cons (deep-rev-if-required (car items)) 
                             result)))) 
   (deep-rev-imp items nil)) 
  
 ;; Usage: 
 (deep-reverse-2 x) 


 (define (eli-deep-reverse lst) 
   (cond ((null? lst) nil) 
         ((pair? (car lst)) 
          (append 
           (eli-deep-reverse (cdr lst)) 
           (list (eli-deep-reverse (car lst))))) 
         (else 
          (append 
           (eli-deep-reverse (cdr lst)) 
           (list (car lst)))))) 
  
 (eli-deep-reverse x) 
