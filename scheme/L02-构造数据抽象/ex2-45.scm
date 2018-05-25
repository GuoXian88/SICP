;self
;高阶过程
(define (right-split painter n)
    (if (= n 0)
        painter
        (let (
            (smaller (right-split painter (- n 1)))
        ) (beside painter (below smaller smaller)))
    )
)

(define right-split (split beside below))

;inner lambda must have a name
(define (split fn1 fn2)
    (lambda (painter n)
        (if (= n 0)
            painter
            (let (
                (smaller (self.call painter (- n 1)))
            ) (fn1 painter (fn2 smaller smaller)))
        )
    )
)


;answer

(define (split orig-placer split-placer) 
   (lambda (painter n) 
     (cond ((= n 0) painter) 
           (else 
            (let ((smaller ((split orig-placer split-placer) painter (- n 1)))) 
              (orig-placer painter (split-placer smaller smaller))))))) 



(define (split f g) 
   (define (rec painter n) 
     (if (= n 1) 
         painter 
         (let ((smaller (rec painter (- n 1)))) 
           (f painter (g smaller smaller))))) 
   rec) 
              