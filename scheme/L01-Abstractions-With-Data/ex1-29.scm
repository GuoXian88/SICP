;自解

(define (sum-simpson f a b n k)
    (define (next a)
        (+ a (* k (h a b n)))
    )
    (if (> k n)
        0
        (+ (* (coeff k n) (f a))
            (sum-simpson f (next a) b n (+ k 1))
        )
    )
)

(define (even? n)
  (= (remainder n 2) 0))

;get coefficient 这个是对的
(define (coeff x n)
    (if (or (= x 0)  (= x n))
        1
        (if (even? x)
            2
            4
        )
    )
)

;这个也是对的，但是漏掉了n是偶数这个条件了,太粗了
(define (h a b n)
    (/ (- b a) n)
)

;answer 1
(define (round-to-next-even x) 
   (+ x (remainder x 2)))


(define (simpson f a b n) 
   (define fixed-n (round-to-next-even n)) 
   (define h (/ (- b a) fixed-n)) 
   (define (simpson-term k) 
     (define y (f (+ a (* k h)))) 
     (if (or (= k 0) (= k fixed-n)) 
         (* 1 y) 
         (if (even? k) 
             (* 2 y) 
             (* 4 y)))) 
   (* (/ h 3) (sum simpson-term 0 inc fixed-n))) 


;answer 2
;;;; Under Creative Commons Attribution-ShareAlike 4.0 
 ;;;; International. See 
 ;;;; <https://creativecommons.org/licenses/by-sa/4.0/>. 
  
 (define-module (net ricketyspace sicp one twentynine) 
   #:export (simpson)) 
  
 (define (sum term a next b) 
   (if (> a b) 
       0 
       (+ (term a) 
          (sum term (next a) next b)))) 
  
 (define (simpson f a b n) 
   (let* ((h (/ (- b a) (* 1.0 n))) 
          (y (lambda (k) (+ a (* k h)))) 
          (ce (lambda (k) ;coefficient 
                (cond ((or (= k 0) (= k n)) 1) 
                      ((even? k) 2) 
                      (else 4)))) 
          (term (lambda (k) 
                  (* (ce k) (f (y k))))) 
          (next (lambda (k) (1+ k)))) 
     (* (/ h 3.0) 
        (sum term 0 next n)))) 
