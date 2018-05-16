;self
(define (make-mobile left right)
    (list left right)
)

(define (make-branch length structure)
    (list length structure)
)

(define (left-branch m)
    (car m)
)

(define (right-branch m)
    (cdr m)
)

(define (branch-length b)
    (car b)
)

(define (total-weight m)

)

;answer
(define (make-mobile left right) 
   (list left right)) 
 (define (left-branch mobile) 
   (car mobile)) 
 (define (right-branch mobile) 
   (car (cdr mobile))) 
  
 (define (make-branch length structure) 
   (list length structure)) 
  
 (define (branch-length branch) 
   (car branch)) 
 (define (branch-structure branch) ; ??
   (car (cdr branch))) 


;version 2
(define (make-mobile left right) 
   (cons left right)) 
  
 (define (left-branch mobile) 
   (car mobile)) 
 (define (right-branch mobile) 
   ;; Have to use cdr at this point  
   (cdr mobile))  
  
 (define (make-branch length structure) 
   (cons length structure)) 
  
 (define (branch-length branch) 
   (car branch)) 
 (define (branch-structure branch) 
   (cdr branch)) 




(define (total-weight mobile) 
   (cond ((null? mobile) 0) 
         ((not (pair? mobile)) mobile) 
         (else (+ (total-weight (branch-structure (left-branch mobile))) 
                  (total-weight (branch-structure (right-branch mobile))))))) 



 (define (torque branch) 
   (* (branch-length branch) (total-weight (branch-structure branch)))) 


 (define (balanced? mobile) 
   (if (not (pair? mobile)) 
       true 
       (and (= (torque (left-branch mobile)) (torque (right-branch mobile))) 
            (balanced? (branch-structure (left-branch mobile))) 
            (balanced? (branch-structure (right-branch mobile)))))) 


; Definition of constructors and selectors 
  
 (define (make-mobile left right) 
   (list left right)) 
 (define (left-branch mobile) 
   (car mobile)) 
 (define (right-branch mobile) 
   (car (cdr mobile))) 
  
 (define (make-branch length structure) 
   (list length structure)) 
 (define (branch-length branch) 
   (car branch)) 
 (define (branch-structure branch) 
   (car (cdr branch))) 
  
 ;; Redefinition of constructors and selectors 
  
 (define (make-mobile left right) 
   (cons left right)) 
 (define (left-branch mobile) 
   (car mobile)) 
 (define (right-branch mobile) 
   (cdr mobile)) 
  
 (define (make-branch length structure) 
   (cons length structure)) 
 (define (branch-length branch) 
   (car branch)) 
 (define (branch-structure branch) 
   (cdr branch)) 
  
  
 (define (total-weight m) 
   (cond ((null? m) 0) 
         ((not (pair? m)) m) 
         (else (+ (total-weight (branch-structure (left-branch  m))) 
                  (total-weight (branch-structure (right-branch m))))))) 
  
 (define m1 (make-mobile 
             (make-branch 4 6) 
             (make-branch 5 
                          (make-mobile 
                           (make-branch 3 7) 
                           (make-branch 9 8))))) 
  
 ;;          4  |  5 
 ;;        +----+-----+ 
 ;;        6        3 |     9 
 ;;               +---+---------+ 
 ;;               7             8 
  
 ;  (total-weight m1) 
 ;  Value: 21 
  
 (define (balanced? m) 
   (cond ((null? m) #t) 
         ((not (pair? m)) #t) 
         (else 
          (and (= (* (branch-length (left-branch m)) 
                     (total-weight (branch-structure (left-branch m)))) 
                  (* (branch-length (right-branch m)) 
                     (total-weight (branch-structure (right-branch m))))) 
               (balanced? (branch-structure (left-branch   m))) 
               (balanced? (branch-structure (right-branch  m))))))) 
  
 (define m2 (make-mobile 
             (make-branch 4 6) 
             (make-branch 2 
                          (make-mobile 
                           (make-branch 5 8) 
                           (make-branch 10 4))))) 
  
 ;;          4  | 2 
 ;;        +----+--+ 
 ;;        6    5  |    10 
 ;;          +-----+----------+ 
 ;;          8                4 
  
 (balanced? m2) 
 ;Value: #t 
 (balanced? m1) 
 ;Value: #f 



