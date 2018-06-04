;元语言抽象
;就是建立新的语言

;元循环求值器
;用与被求值的语言同样的语言写出的求值器被称为元循环


;两个部分：组合式先求值其中的子表达式，在将一个复合过程应用于一集实际参数时，我们在一个新的环境里求值这个环境的体。构造这一环境的方式就是用一个frame扩充该过程对象的环境部分，frame中包含的是这个过程的各个形式参数与这一过程应用的各个实际参数的约束

;`eval` and `apply` 

;使用抽象让求值器独立于语言的具体表示

;求值器的内核

eval <exp> <env>


(define (eval exp env)
    (cond ((self-evaluatinng? exp) exp)
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
        ((application? exp) (apply (eval (operator exp) env)
                                    (list-of-values (operands exp) env)
        ))
        (else (error "Unknown expression type -- EVAL" exp))
    )
)

;如何能不修改eval的定义而添加新的表达式类型?用数据导向的方式来分派表达式的类型


(define (apply procedure arguments)
    (cond ((primitive-procedure? procedure) (apply-primitive-procedure procedure))
        ((compound-procedure? procedure)
            (eval-sequence (procedure-body procedure)
                (extend-environment (procedure-parameters procedure) arguments (procedure-environment procedure))
            )
        )
        (else (error "Unknown procedure type -- APPLY" procedure))
    )
)


(define (list-of-values exps env)
    (if (no-operands? exps)
        '()
        (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env)
        )
    )
)

(define (eval-if exp env)
    (if (true? (eval (if-predicate exp) env))
        (eval (if-consequent exp) env)
        (eval (if-alternative exp) env)
    )
)

;被实现的语言(if-predicate)与实现所用的语言(true?) 

(define (eval-sequence exps env)
    (cond ((last-exp? exps) (eval (first-exp) env))
        (else (eval (first-exp exps) env)
            (eval-sequence (rest-exps exps) env)
        )
    )
)

(define (eval-assignment exp env)
    (set-variable-value! (assignment-variable exp)
        (eval (assignment-value exp) env)
    env)
'ok)


(define (eval-definition exp env)
    (define-variable! (definition-variable exp)
        (eval (definition-values exp) env)
    env)
'ok)


(define (self-evaluatinng? exp)
    (cond ((number? exp) true)
        ((string? exp) true)
        (else false)
    )
)


(define (variable? exp) (symbol? exp))


(define (quoted? exp) (tagged-list? exp 'quote))
; 'a: quote a
(define (text-of-quotation exp) (cadr exp))

(define (tagged-list? exp tag)
    (if (pair? exp)
        (eq? (car exp) tag)
        false
    )
)

(define (assignment? exp)
    (tagged-list? exp 'set!)
)

(define (assignment-variable exp) (cadr exp))

(define (assignment-value exp) (caddr exp))


(define (definition? exp)
    (tagged-list? exp 'define)
)

(define (definition-variable exp)
    (if (symbol? (cadr exp))
        (cadr exp)
        (caadr exp)
    )
)


(define (definition-value exp)
    (if (symbol? (cadr exp))
        (caddr exp)
        (make-lambda (cdadr exp)
            (cddr exp)
        )
    )
)

(define (lambda? exp) (tagged-list? exp 'lambda))
(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))

(define (make-lambda parameters body)
    (cons 'lambda (cons parameters body))
)

(define (if? exp) (tagged-list? exp 'if))

(define (if-predicate exp) (cadr exp))

(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
    (if (not (null? (cdddr exp)))
        (cadddr exp)
        'false
    )
)





