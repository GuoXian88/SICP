;self


;answer
 (define (count-pairs x) 
   (let ((encountered '())) 
     (define (helper x) 
       (if (or (not (pair? x)) (memq x encountered)) 
         0 
         (begin 
           (set! encountered (cons x encountered)) 
           (+ (helper (car x)) 
              (helper (cdr x)) 
              1)))) 
   (helper x))) 

   The text suggests that one should use a structure to keep track of pairs that have already been encountered. Notice that there is a let statement defining encountered around the internal definition of a helper function, so that this list is recreated every time count-pairs is invoked, and so that the helper has access to all encountered pairs at any point of execution.