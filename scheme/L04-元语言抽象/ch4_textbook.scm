;元语言抽象
;求值器就是interpreter
;就是建立新的语言 在一些语言的基础上构造新的语言
;可以自己实现求值规则

;利用流的概念去松开 计算机里的时间表示 与现实世界的时间之间 的联系，以降低由状态和赋值带来的复杂性

;Lisp求值器的基本结构

;元循环求值器
;用与被求值的语言同样的语言写出的求值器被称为元循环


;两个部分：组合式先求值其中的子表达式，在将一个复合过程应用于一集实际参数时，我们在一个新的环境里求值这个环境的体。构造这一环境的方式就是用一个frame扩充该过程对象的环境部分，frame中包含的是这个过程的各个形式参数与这一过程应用的各个实际参数的约束

;`eval` and `apply` 

;使用抽象让求值器独立于语言的具体表示
;数据抽象技术，松开一般性的操作规则与表达式特定表示的细节方式之间的联系
;求值器的内核

eval <exp> <env>


(define (eval exp env)
    (cond ((self-evaluating? exp) exp) ;自求值表达式，如各种数，直接返回本身
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
        ;组合式
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
;cadr的取值貌似是从右到左的，先是cdr再car
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

(define (setup-environment)
    (let ((initial-env (extend-environment (primitive-procedure-names)
    (primitive-procedure-objects)
    the-empty-environment)))
        (define-variable! 'true true initial-env)
        (define-variable! 'false false initial-env)
    initial-env)
)

(define the-global-environment (setup-environment))


(define (primitive-procedure? proc)
    (tagged-list? proc 'primitive)
)

(define (primitive-implementation proc) (cadr proc))

(define primitive-procedures (list (list 'car car)
    (list 'cdr cdr)
    ;...
))

(define (primitive-procedure-names)
    (map car primitive-procedures)
)

(define (primitive-procedure-objects)
    (map (lambda (proc) (list 'primitive (cadr proc)))
        primitive-procedures
    )
)


(define (apply-primitive-procedure proc args)
    (apply-in-underlying-scheme (primitive-implementation proc) args)
)

;driver loop

(define input-prompt ";;; M-Eval input:")
(define output-prompt ";;; M-Eval value:")



(define (driver-loop)
    (prompt-for-input input-prompt)
    (let ((input (read)))
        (let ((output (eval input the-global-environment)))
            (announce-output output-prompt)
            (user-print output)
        )
    )
    (driver-loop)
)

(define (prompt-for-input string)
    (newline) (newline)
    (display string)
    (newline)
)

(define (announce-output string)
    (newline)
    (display string)
    (newline)
)


(define (user-print object)
    (if (compound-procedure? object)
        (display (list 'compound-procedure (procedure-parameters object) (procedure-body object) '<procedure-env>))
        (display object)
    )
)

;将数据作为程序
;将程序看成一个抽象的(可能无穷大的)机器的一个描述.解释器是通用机器，可以用来描述任何机器,只要其他机器作为输入，解释器就能具有该机器的功能.


;内部定义
;在块结构里，一个局部名字的作用域，应该是相应define的求值所在的整个过程体

;定义在求值之前

;将语法分析与执行分离

(define (eval exp env)
    ((analyze exp) env)
)

(define (analyze exp)
    (cond ((self-evaluating? exp) (analyze-self-evaluating exp))
        ((variable? exp) (analyze-variable exp))
        ((quoted? exp) (analyze-quoted exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence exp))
        ((cond? exp) (analyze (cond->if exp)))
        ;组合式
        ((application? exp) (analyze-application exp))
        (else (error "Unknown expression type -- ANALYZE" exp))
    )
)



(define (analyze-self-evaluating exp)
    (lambda (env) exp)
)
;对于引号表达式可以在分析时提取出被引表达式，而不是在执行中去做的方式，这样可以提高一点效率
(define (analyze-quoted exp)
    (let ((qval (text-of-quotation exp)))
        (lambda (env) qval)
    )
)

(define (analyze-variable exp)
    (lambda (env) (lookup-variable-value exp env))
)

(define (analyze-assignment exp)
    (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp)))
    ) (lambda (env) (set-variable-value! var (vproc env) env) 'ok))
)


(define (analyze-definition exp)
    (let ((var (definition-variable exp))
        (vproc (analyze (definition-value exp)))
    ) (lambda (env) (define-variable! var (vproc env) env) 'ok))
)



;scheme的变形--惰性求值

;正则序-- lazy: 优点是使某些过程能够完成有用的计算，即使对它们的参数的求值将产生错误甚至根本不能终止
;如cons就是非严格的，在不知道元素值的情况下做各种操作

;惰性求值的解释器：延时参数不进行求值,将其变成一种thunk的对象 thunk里包含产生这一参数的值 (在需要 的时候) 所需的全部信息


;非确定性计算
;使程序员摆脱如何做出这些选择的细节