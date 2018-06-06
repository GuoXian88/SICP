;self
(define x 3)
;把x当成一个过程应用
(define (tagged-list? exp tag)
    (if (pair? exp)
        (eq? (car exp) tag)
        false
    )
)

(define (eval exp env)
    (cond 
        ((call? exp) (apply (eval (operator exp) env)
                                    (list-of-values (operands exp) env)
        ))
        ((self-evaluatinng? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp) (make-procedure (lambda-parameters exp)
                                    (lambda-body exp)
                                    env
        ))
        ((begin? exp) (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        
        (else (error "Unknown expression type -- EVAL" exp))
    )
)

(define (call? exp)
    (tagged-list? exp 'call)
)


;answer
;; a Assignment expressions are technically pairs and will be evaluated as applications. Evaluating an assignment as an application will cause the evaluator to try to evaluate the assignment variable instead of treating it as a symbol. 
  
 ;; b 
 (define (application? exp) (tagged-list? exp 'call))
 ;忘记这两个也要修改了
 (define (operator exp) (cadr exp)) 
 (define (operands exp) (cddr exp)) 
