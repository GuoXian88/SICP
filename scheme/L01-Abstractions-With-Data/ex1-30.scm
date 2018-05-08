;自解

;recursive 为啥我看着像迭代呢
(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a)
            (sum term (next a) next b)
        )
    )
)

;没有调用iter..
(define (sum term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter a (+ result (term a)))
        )
        (sum term (next a) next b)
    )
)

; answer
 (define (itersum term a next b) 
  (define (iter a result) ;只传入需要更新的参数
          (if (> a b) 
              result 
              (iter (next a) (+ result (term a))))) 
  (iter a 0)) 