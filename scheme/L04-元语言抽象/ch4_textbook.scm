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





