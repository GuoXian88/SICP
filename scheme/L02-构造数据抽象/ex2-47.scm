;self
(define (make-frame edge1 edge2)
    (list origin edge1 edge2)
)


(define (make-frame origin edge1 edge2)
    (cons origin (cons edge1 edge2))
)



;answer

 ;; First implementation. 
  
 (define (make-frame origin edge1 edge2) 
   (list origin edge1 edge2)) 
 (define (frame-origin f) (car f)) 
 (define (frame-edge1 f) (cadr f)) 
 (define (frame-edge2 f) (caddr f)) 
  
 ;; Test just using scalars, lazy.  That's there's no type safety might 
 ;; be worrisome to some coming from Java/C++. 
 (define f (make-frame 1 2 3)) 
 (frame-origin f) 
 (frame-edge1 f) 
 (frame-edge2 f) 
  
 ;; Second imp. 
  
 (define (make-frame origin edge1 edge2) 
   (cons origin (cons edge1 edge2))) 
 (define (frame-origin f) (car f)) 
 (define (frame-edge1 f) (cadr f)) 
 (define (frame-edge2 f) (cddr f)) 
  
 ;; same test as before applies. 
  