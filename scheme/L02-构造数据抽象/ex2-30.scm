;self
(define (square-tree tree)
    (cond ((null? tree) nil) 
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))
        ))
    )
)


(define (square-tree tree)
    (map (lambda (sub-tree)
        (if (pair? sub-tree)
            (square-tree sub-tree)
            (square sub-tree)
        )
    ) tree)
)
;answer
;; Defining directly: 
 (define (square-tree tree) 
   (define nil '())  ;; my env lacks nil 
   (cond ((null? tree) nil) 
         ((not (pair? (car tree))) 
          (cons (square (car tree)) (square-tree (cdr tree)))) 
         (else (cons (square-tree (car tree)) 
                     (square-tree (cdr tree)))))) 
  
 ;; The above works, but there's no need to rip the tree apart in the (not 
 ;; ...) cond branch, since square-tree takes the tree apart for us in 
 ;; the else branch if we do one more recurse.  The following is 
 ;; better: 
 (define (sq-tree-2 tree) 
   (define nil '()) 
   (cond ((null? tree) nil) 
         ((not (pair? tree)) (square tree)) 
         (else (cons (sq-tree-2 (car tree)) 
                     (sq-tree-2 (cdr tree)))))) 
  
  
 ;; By using map: 
 (define (sq-tree-with-map tree) 
   (define nil '()) 
   (map (lambda (x) 
          (cond ((null? x) nil) 
                ((not (pair? x)) (square x)) 
                (else (sq-tree-with-map x)))) 
        tree)) 
  
 ;; Usage 
 (square-tree my-tree) 
 (sq-tree-2 my-tree) 
 (sq-tree-with-map my-tree) 
  
  
 ;; Originally, had the following for the else in sq-tree-with-map: 
 ;; 
 ;;   (else (cons (sq-tree-with-map (car x))  
 ;;               (sq-tree-with-map (cdr x)))))) 
 ;; 
 ;; defining the else clause this way raised an error: 
 ;; 
 ;;    The object 3, passed as an argument to map, is not a list. etc. 
 ;; 
 ;; my-tree had a primitive, 3, as one branch of the tree, so calling 
 ;; sq-tree-with-map eventually resolved to (sq-tree-with-map 3), which 
 ;; chokes.  Anyway, it was too much work, since all that was needed 
 ;; was a call to map *that* tree. 