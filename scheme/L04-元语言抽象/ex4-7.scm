;self

;answer
;; let* expression 
 (define (let*? expr) (tagged-list? expr 'let*)) 
 (define (let*-body expr) (caddr expr)) 
 (define (let*-inits expr) (cadr expr)) 
 (define (let*->nested-lets expr) 
         (let ((inits (let*-inits expr)) 
                   (body (let*-body expr))) 
                 (define (make-lets exprs) 
                         (if (null? exprs) 
                                 body 
                                 (list 'let (list (car exprs)) (make-lets (cdr exprs))))) 
                 (make-lets inits))) 

The body of let* is a sequence of expressions, so I think it should be accessed with cddr. It can be transformed to a single expression with sequence->exp which is defined in the book.


(define (let-args exp) (cadr exp)) 
 (define (let-body exp) (cddr exp)) 
 (define (make-let args body) (cons 'let (cons args body))) 
  
 (define (let*->nested-lets exp) 
   (define (reduce-let* args body) 
     (if (null? args) 
         (sequence->exp body) 
         (make-let (list (car args)) 
                   (list (reduce-let* (cdr args) body))))) 
   (reduce-let* (let-args exp) (let-body exp))) 
  

;another

 ;; var-defs and body should be list 
 (define (make-let var-defs body) 
   (cons 'let (cons var-defs body))) 
 (define (let*? exp) (tagged-list? exp 'let*)) 
 (define (let*->let exp) 
   (car 
    (fold-right (lambda(new rem) 
                  (list (make-let (list new) rem))) 
                (let-body exp) 
                (let-vardefs exp)))) 
                