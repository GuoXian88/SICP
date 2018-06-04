;self
;left to right list-of-values

(define (l2r-list-of-values exps env)
    (if (no-operands? exps)
        '()
        (cons (eval (first-operand exps) env)
            (l2r-list-of-values (rest-operands exps) env)
        )
    )
)

;right to left list-of-values

(define (l2r-list-of-values exps env)
    (if (no-operands? exps)
        '()
        (cons (eval (last-operand exps) env)
            (l2r-list-of-values (rest-operands exps) env)
        )
    )
)
;answer

;; left to righ 
 (define (list-of-values1 exps env) 
   (if (no-operand? exps) 
       '() 
       (let* ((left (eval (first-operand exps) env)) 
                 (right (eval (rest-operands exps) env))) 
         (cons left right)))) 
  
 ;; right to left 这个有点机智的!!!
 (define (list-of-values2 exps env) 
   (if (no-operand? exps) 
       '() 
       (let* ((left (eval (rest-operands exps) env)) 
                 (right (eval (first-operand exps) env))) 
         (cons left right)))) 

;another

(define (list-of-values-lr exps env) 
   (if (no-operands? exps) 
       '() 
       (let ((first (eval (first-operand exps) env))) 
         (let ((rest (list-of-values-lr (rest-operands exps) env))) 
           (cons first rest))))) 
  
 (define (list-of-values-rl exps env) 
   (if (no-operands? exps) 
       '() 
       (let ((rest (list-of-values-rl (rest-operands exps) env))) 
         (let ((first (eval (first-operand exps) env))) 
           (cons first rest))))) 


;another

;;; left-to-right 
 (define (list-of-values-l2r exps env) 
   (if (no-operands? exps) 
       '() 
       (let ((first-exp (eval (first-operand exps) env))) 
         (cons first-exp 
               (list-of-values-l2r (rest-operands exps) env))))) 
  
 ;;; right-to-left 
 (define (list-of-values-r2l exps env) 
   (list-of-values-l2r (reverse exps) env))