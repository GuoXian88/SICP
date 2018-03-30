;Exercise 1.11.  A function f is defined by the rule that f(n) = n if n<3 and f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n> 3. Write a procedure that computes f by means of a recursive process. Write a procedure that computes f by means of an iterative process.

; recursive
(define (fr n)
    (if (< n 3)
        n
        (+ (f (- n 1))
            (* 2 (f (- n 2)))
            (* 3 (f (- n 3)))
        )
    )
)

;iterative(wrong)
(define (fi n)
    (if (< n 3)
        n
        (fi-iter n 0)
    )
)

(define (fi-iter n res)
    (if (= n 0)
        res
        (fi-iter (- n 1) (+ res (+ (fi-iter (- n 1) res)
                                    (* 2 (fi-iter (- n 2) res))
                                    (* 3 (fi-iter (- n 3) res))
        ))
        )
    )
)

;answer
(define (foo n) 
    (define (foo-iter a b c n) 
      ;; a = f(n - 1), b = f(n - 2), c = f(n - 3). 
      ;; return a + 2b + 3c 
      (if (< n 3) 
          a 
          (foo-iter (+ a (* 2 b) (* 3 c)) a b (- n 1)))) 
    (if (< n 3) 
        n 
        (foo-iter 2 1 0 n)))


 
(define (f n) 
    ;; Given starting coefficients (a, b, c) = (1, 2, 3), 
    ;; where f(n) = 1 f(n-1) + 2 f(n-2) + 3 f(n-3), 
    ;; f-iter calculates new (a, b, c) such that 
    ;; f(n) = a f(2) + b f(1) + c f(0), 
    ;; where integer n > 3. 
    (define (f-iter n a b c) 
        (if (= n 3) 
            (+ (* a 2)  ;; f(2) = 2 
                (* b 1)  ;; f(1) = 1 ;; (* b 1) = b, and 
                (* c 0)) ;; f(0) = 0 ;; (* c 0) = 0, which can be omitted, 
                                    ;; but shown here for completeness. 
            (f-iter (- n 1)       ;; decrement counter 
                    (+ b a)       ;; new-a = a + b 
                    (+ c (* 2 a)) ;; new-b = 2a + c 
                    (* 3 a))))    ;; new-c = 3a 
    ;; main body 
    (if (< n 3) 
        n 
        (f-iter n 1 2 3)))


(define (fn-iterate n) 
    (define (fn-iter count n f1 f2 f3) 
        (if (= count n) f3 (fn-iter (+ count 1) n f2 f3 (+ (* 3 f1) (* 2 f2) f3)))) 
    (if (<= n 3) n (fn-iter 3 n 1 2 3))) 