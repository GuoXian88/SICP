;坑.这里显式的相乘会递归两次的，相当于重复计算多了一次 lg --> n
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))


;solution 树形递归与树的深度呈指数关系，这里e^(lgn) --> n
;Instead of a linear recursion, the rewritten expmod generates a tree recursion, whose execution time grows exponentially with the depth of the tree, which is the logarithm of N. Therefore, the execution time is linear with N.

