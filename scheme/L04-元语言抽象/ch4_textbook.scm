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
    (cond ((self-evaluating? exp) exp)
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



(define (make-if predicate consequent alternative)
    (list 'if predicate consequent alternative)
)


(define (begin? exp)
    (tagged-list? exp 'begin)
)

(define (begin-actions exp)
    (cdr exp)
)

(define (last-exp? seq) (null? (cdr seq)))

(define (first-exp seq) (car seq))

(define (rest-exps seq) (cdr seq))

(define (sequence->exp seq)
    (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))
    )
)

(define (make-begin seq) (cons 'begin seq))


;过程应用
(define (application? exp) (pair? exp))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))

(define (no-operands? ops) (null? ops))

(define (first-operand ops) (car ops))

(define (rest-operands ops) (cdr ops))


;派生表达式 如cond可转化成if

(define (cond? exp) (tagged-list? exp 'cond))

(define (cond-clauses exp) (cdr exp))

(define (cond-else-clause? clause) (eq? (cond-predicate clause) 'else))

(define (cond-predicate clauses) (car clauses))

(define (cond-actions clauses) (cdr clauses))

(define (cond->if exp)  (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
    (if (null? clauses)
        'false
        (let ((first (car clauses))
                (rest (cdr clauses))
        )
            (if (cond-else-clause? rest)
                (if (null? rest)
                    (sequence->exp (cond-actions first))
                    (error "ELSE clause isn't last -- COND->IF" clauses)
                )
                (make-if (cond-predicate first)
                    (sequence->exp (cond-actions first))
                    (expand-clauses rest)
                )
            )
        )
    )
)


;true false检测

(define (true? exp)
    (not (eq? exp false))
)
(define (false? exp)
    (eq? exp false)
)

;过程的表示

(define (make-procedure parameters body env)
    (list 'procedure parameters body env)
)

(define (compound-procedure? p)
    (tagged-list? p 'procedure)
)

(define (procedure-parameters p) (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))

;对环境的操作, 环境看成一个表，表真是太强了(指针)

(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())

(define (make-frame variables values)
    (cons variables values)
)

(define (frame-variables f) (car f))
(define (frame-values f) (cdr f))

(define (add-binding-to-frame! var val frame)
    (set-car! frame (cons var (car frame)))
    (set-cdr! frame (cons val (cdr frame)))
)


(define (extend-environment vars vals base-env)
    (if (= (length vars) (length vals))
        (cons (make-frame vars vals) base-env)
        (if (< (length vars) (length vals))
            (error "Too many arguments supplied" vars vals)
            (error "Too few arguments supplied" vars vals)
        )
    )
)


(define (lookup-variable-value var env)
    (define (env-loop env)
        (define (scan vars vals)
            (cond ((null? vars) (env-loop (enclosing-environment env)))
                ((eq? var (car vars)) (car vals))
                (else (scan (cdr vars) (cdr vals)))
            )
        )
        (if (eq? env the-empty-environment)
            (error "Unbound variable" var)
            (let ((frame (first-frame env)))
                (scan (frame-variables frame) (frame-values frame))
            )
        )
    )
    (env-loop env)
)


(define (set-variable-value! var env)
    (define (env-loop env)
        (define (scan vars vals)
            (cond ((null? vars) (env-loop (enclosing-environment env)))
                ((eq? var (car vars)) (set-car! vals val))
                (else (scan (cdr vars) (cdr vals)))
            )
        )
        (if (eq? env the-empty-environment)
            (error "Unbound variable -- SET!" var)
            (let ((frame (first-frame env)))
                (scan (frame-variables frame) (frame-values frame))
            )
        )
    )
    (env-loop env)
)



(define (define-variable! var val env)
    (let ((frame (first-frame env)))
        (define (scan vars vals)
            (cond ((null? vars) (add-binding-to-frame! var val frame))
                ((eq? var (car vars)) (set-car! vars val))
                (else (scan (cdr vars) (cdr vals)))
            )
        )
        (scan (frame-variables frame)
            (frame-values frame)
        )
    )
)

;上面的效率很低，查找变量的速度慢

;作为程序运行这个求值器




