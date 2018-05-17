;self
 (define (tree-map proc tree) 
   (define nil '()) 
   (map (lambda (x) 
          (cond ((null? x) nil) 
                ((not (pair? x)) (proc x)) 
                (else (tree-map proc x)))) 
        tree)) 
;answer

  
 (define (tree-map proc tree) 
   (define nil '()) 
   (map (lambda (subtree) 
          (cond ((null? subtree) nil) 
                ((not (pair? subtree)) (proc subtree)) 
                (else (tree-map proc subtree)))) 
        tree)) 
