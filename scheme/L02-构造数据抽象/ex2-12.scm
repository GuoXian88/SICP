;self solution
(define (make-center-width c w)
    (make-interval (- c w) (+ c w))
)


(define (center i)
    (/ (+ (lower-bound i) (upper-bound i)) 2)
)

(define (width i)
    (/ (- (upper-bound i) (lower-bound i)) 2)
)

;误差构造区间 这个解错了
(define (make-center-percent c p)
    (make-interval ((* c (- 1 p)) (* c (+ 1 p)))
)

;选择函数
(define (percent i)
    (/ (- (center i) (lower-bound i)) (center i))
)

;answer
 ;; ex 2.12 
  
 (define (make-interval a b) (cons a b)) 
 (define (upper-bound interval) (max (car interval) (cdr interval))) 
 (define (lower-bound interval) (min (car interval) (cdr interval))) 
 (define (center i) (/ (+ (upper-bound i) (lower-bound i)) 2)) 
  
 ;; Percent is between 0 and 100.0 
 (define (make-interval-center-percent c pct) 
   (let ((width (* c (/ pct 100.0)))) 
     (make-interval (- c width) (+ c width)))) 
  
 (define (percent-tolerance i) 
   (let ((center (/ (+ (upper-bound i) (lower-bound i)) 2.0)) 
         (width (/ (- (upper-bound i) (lower-bound i)) 2.0))) 
     (* (/ width center) 100))) 
  
  
 ;; A quick check: 
  
 (define i (make-interval-center-percent 10 50)) 
 (lower-bound i) 
 (upper-bound i) 
 (center i) 
 (percent-tolerance i) 
  
  