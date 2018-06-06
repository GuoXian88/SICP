;self
;if example
(define (eval-if exp env)
    (if (true? (eval (if-predicate exp) env))
        (eval (if-consequent exp) env)
        (eval (if-alternative exp) env)
    )
)
;and
(define (eval-and exp env)
    (cond ((eval (last-exp? exp)) (eval exp env))
        ((eval (first-exp exp) env) (eval-and (rest-exp exp) env))
        (else false)
    )
)

(define (eval-or exp env)
    (cond ((eval (last-exp? exp)) (eval exp env))
        ((not (eval (first-exp exp) env)) (eval-and (rest-exp exp) env))
        (else (first-exp exp))
    )
)
;answer

