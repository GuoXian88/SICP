;Newton's method
;Now let's formalize the process in terms of procedures. We start with a value for the radicand (the number whose square root we are trying to compute) and a value for the guess. If the guess is good enough for our purposes, we are done; if not, we must repeat the process with an improved guess. We write this basic strategy as a procedure:

;main Newton's method

(define (square x)
    (* x x)
)

(define (abs x)
    (if (< x 0)
        (- x)
        x)
)

(define (average x y)
    (/ (+ x y) 2)
)


(define (improve guess x)
    (average x (/ x guess))
)

;误差在指定范围内
(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001)
)

(define (sqr-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqr-iter (improve guess x) x))
)


(define (sqrt x)
    (sqr-iter 1.0 x)
)

;1.6
;;new-if does not use normal order evaluation, it uses applicative order evaluation. That is, the interpreter first evaluates the operator and operands and then applies the resulting procedure to the resulting arguments. As with Excercise 1.5, this results in an infinite recursion because the else-clause is always evaluated, thus calling the procedure again ad infinitum.

;;The if statement is a special form and behaves differently. if first evalutes the predictate, and then evaluates either the consequent (if the predicate evalutes to #t) or the alternative (if the predicate evalues to #f). This is key difference from new-if -- only one of the two consequent expressions get evaluated when using if, while both of the consequent expressions get evaluated with new-if.

;;new-if is a procedure, and under applicative-order evaluation, all its arguments will be evaluated first before the procedure application is even started. The third argument to the new-if procedure, i.e. the recursive call to sqrt-iter, will always be evaluated. It is the evaluation of this third argument that causes an infinite loop. In particular, the else-clause mentioned by jsdalton is never evaluated. Indeed, the new-if procedure body (which contains the cond special form) is never even applied to the resulting 3 arguments as the 3rd argument never stops evaluating itself!

