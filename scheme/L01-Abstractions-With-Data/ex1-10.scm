;Exercise 1.10.  The following procedure computes a mathematical function called Ackermann's function.

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

;What are the values of the following expressions?

(A 1 10)
; 2(A 1 9) 2^2(A 1 8) ... 2^9(A 1 1) = 2^10 1024

(A 2 4)
; (A 1 A(2 3)) (A 1 (A 1 (A 1 (A 2 1)))) 2^(2^(2^2)) = 2^16 65536

(A 3 3)
; (A 2 A(3 2)) (A 2 (A 2 (A 3 1))) (A 2 2^2)同上 65536

;Consider the following procedures, where A is the procedure defined above:

(define (f n) (A 0 n))
; 2n
(define (g n) (A 1 n))
; 2^n

(define (h n) (A 2 n))
; 2^(2^...2^2)  n-2层最后一层是2^2

(define (k n) (* 5 n n))

;Give concise mathematical definitions for the functions computed by the procedures f, g, and h for positive integer values of n. For example, (k n) computes 5n^2.


(f n): 2n
(g n): 2^{n}
(h n): 2^2^… (n-1 times)