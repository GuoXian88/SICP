;self
(define (fringe tree)
    (define (iter branch res)
        (if (not (pair? branch))
            (append res branch)
            (iter (car branch) res)
            (iter (cdr branch) res)
        )
    )
    (iter tree nil)
)


;answer

;; Fringe.   
  
 (define my-tree (list 1 (list 2 (list 3 4) (list 5 6)) (list 7 (list 8)))) 
  
 ;; First try.  If the current element is a leaf, cons it to the fringe 
 ;; of the rest.  If the current element is a tree, cons the fringe if 
 ;; it to the fringe of the rest.  .... Won't work because the bad line 
 ;; indicated won't build a flat list, it will always end in nested 
 ;; cons. 
 (define (fringe tree) 
   (define nil '()) 
   (if (null? tree)  
       nil 
       (let ((first (car tree))) 
         (if (not (pair? first)) 
             (cons first (fringe (cdr tree))) 
             ;; bad line follows: 
             (cons (fringe first) (fringe (cdr tree))))))) 
  
 (fringe my-tree) 
  
 ;; Second try. 
 ;; Need to store fringe of the cdr, then add the fringe of the car to 
 ;; that. 
 (define (fringe tree) 
   (define nil '()) 
  
   (define (build-fringe x result) 
     (cond ((null? x) result) 
           ((not (pair? x)) (cons x result)) 
           (else (build-fringe (car x)  
                               (build-fringe (cdr x) result))))) 
  
   (build-fringe tree nil)) 
  
 ;; Usage: 
 (fringe my-tree) 


 (define (fringe tree) 
   (define nil '()) 
   (if (null? tree)  
       nil 
       (let ((first (car tree))) 
         (if (not (pair? first)) 
             (cons first (fringe (cdr tree))) 
             (append (fringe first) (fringe (cdr tree))))))) 


;; construct the list from the right of the tree, to the left 
 (define (fringe T) 
   (define (iter T R) 
     (cond ((null? T) R) 
           ((not (pair? T)) (cons T R)) 
           (else (iter (car T) 
                       (iter (cdr T) R))))) 
   (iter T '())) 
  
  
 (define x '(1 (2 (3 4)))) 
  
 (fringe x)  ;; (1 2 3 4) 
 (fringe (list x x)) ;; (1 2 3 4 1 2 3 4) 
 (fringe '(2)) ;; 2 


(define (reverse x) 
   (define (iter x acc) 
     (if (null? x) 
         acc 
         (iter (cdr x) 
               (cons (car x) acc)))) 
   (iter x nil)) 
  
 (define (fringe x) 
   (define (collect stack acc) 
     (if (null? stack) 
         acc 
         (let ((top (car stack))) 
           (cond ((null? top) (collect (cdr stack) acc)) 
                 ((not (pair? top)) (collect (cdr stack) (cons top acc))) 
                 (else (collect (cons (car top) 
                                      (cons (cdr top) (cdr stack))) 
                                acc)))))) 
   (reverse (collect (list x) nil))) 