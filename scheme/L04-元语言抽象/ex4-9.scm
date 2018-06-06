;self


;answer
;; i only implement while. 
 ;; add this to eval 
  ((while? expr) (evaln (while->combination  expr) env)) 
  
 ;; while expression 
 (define (while? expr) (tagged-list? expr 'while)) 
 (define (while-condition expr) (cadr expr)) 
 (define (while-body expr) (caddr expr)) 
 (define (while->combination expr) 
         (sequence->exp 
                 (list (list 'define  
                                 (list 'while-iter) 
                                         (make-if (while-condition expr)  
                                                          (sequence->exp (list (while-body expr)  
                                                                                        (list 'while-iter))) 
                                                          'true)) 
                           (list 'while-iter)))) 
Because while has been implemented by meteorgan as a define expression, with a single name 'while-iter', it can cause serious nameclash issues if there are two while loops in a single procedure!

The alternative is to implement while with a lambda i.e. with a let expression as below (below assumes the let macro has been installed into eval procedure):

(define (while? exp) (tagged-list? exp 'while)) 
 (define (while-pred exp)(cadr exp)) 
 (define (while-actions exp) (caddr exp)) 
  
 (define (make-single-binding var val)(list (list var val))) 
 (define (make-if-no-alt predicate consequent)(list 'if predicate consequent)) 
 (define (make-combination operator operands) (cons operator operands)) 
  
 (define (while->rec-func exp) 
   (list 'let (make-single-binding 'while-rec '(quote *unassigned*)) 
         (make-assignment 'while-rec 
              (make-lambda '() 
                     (list (make-if-no-alt  
                                 (while-pred exp) 
                                 (make-begin (append (while-actions exp) 
                                                       (list (make-combination 'while-rec '())))))))) 
         (make-combination 'while-rec '()))) 

An alternative, not very clever way of dealing with the scope issue karthikk points out is to have a name to use in the procedure definition as part of the while construct -- i.e., have while syntax be something like this: `(while <name> <predicate> <body>)`. Unusual, but much cleaner.