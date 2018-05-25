;self

;answer

(define (sum? expr) 
   (eq? '+ (smallest-op expr))) 
  
 (define (product? expr) 
   (eq? '* (smallest-op expr))) 

(define (smallest-op expr) 
   (accumulate (lambda (a b) 
                 (if (operator? b) 
                     (min-precedence a b) 
                     a)) 
               'maxop 
               expr)) 

 (define *precedence-table* 
   '( (maxop . 10000) 
      (minop . -10000) 
      (+ . 0) 
      (* . 1) )) 
  
 (define (operator? x) 
   (define (loop op-pair) 
     (cond ((null? op-pair) #f) 
           ((eq? x (caar op-pair)) #t) 
           (else (loop (cdr op-pair))))) 
   (loop *precedence-table*)) 
  
 (define (min-precedence a b) 
   (if (precedence<? a b) 
       a 
       b)) 
  
 (define (precedence<? a b) 
   (< (precedence a) (precedence b))) 
  
 (define (precedence op) 
   (define (loop op-pair) 
     (cond ((null? op-pair) 
            (error "Operator not defined -- PRECEDENCE:" op)) 
           ((eq? op (caar op-pair)) 
            (cdar op-pair)) 
           (else 
            (loop (cdr op-pair))))) 
   (loop *precedence-table*)) 


(define (augend expr) 
   (let ((a (cdr (memq '+ expr)))) 
     (if (singleton? a) 
         (car a) 
         a))) 


 (define (prefix sym list) 
   (if (or (null? list) (eq? sym (car list))) 
       '() 
       (cons (car list) (prefix sym (cdr list))))) 
  
 (define (addend expr) 
   (let ((a (prefix '+ expr))) 
     (if (singleton? a) 
         (car a) 
         a))) 


(define (make-sum a1 a2) 
   (cond ((=number? a1 0) a2) 
         ((=number? a2 0) a1) 
         ((and (number? a1) (number? a2)) 
          (+ a1 a2)) 
         (else (list a1 '+ a2)))) 


(define (multiplier expr) 
   (let ((m (prefix '* expr))) 
     (if (singleton? m) 
         (car m) 
         m))) 
  
 (define (multiplicand expr) 
   (let ((m (cdr (memq '* expr)))) 
     (if (singleton? m) 
         (car m) 
         m))) 
  
 (define (make-product m1 m2) 
   (cond ((=number? m1 1)  m2) 
         ((=number? m2 1)  m1) 
         ((or (=number? m1 0) (=number? m2 0))  0) 
         ((and (number? m1) (number? m2)) 
          (* m1 m2)) 
         (else (list m1 '* m2)))) 