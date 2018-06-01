;self

;answer
 (define (contains-cycle? x) 
   (define(inner return) 
      (let((C '())) 
        (define (loop lat) 
          (cond 
            ((not (pair? lat)) (return #f)) 
            (else 
             (if (memq (car lat) C) 
                 (return #t) 
                 (begin 
                   (set! C (cons (car lat) C)) 
                   (if(pair? (car lat)) 
                      ( or (contains-cycle? (car lat)) 
                           (loop (cdr lat))) 
                      (loop (cdr lat)))))))) 
        (loop x))) 
   (call/cc inner))


(define (cycle? x) 
   (define visited nil) 
   (define (iter x) 
     (set! visited (cons x visited)) 
     (cond ((null? (cdr x)) false) 
           ((memq (cdr x) visited) true) 
           (else (iter (cdr x))))) 
   (iter x)) 