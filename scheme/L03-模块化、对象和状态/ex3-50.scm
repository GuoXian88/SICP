;self
(define (stream-map proc .arg streams)
    (if (stream-null? (streams))
        the-empty-stream
        (cons-stream (proc (stream-car streams) arg)
            (stream-map proc arg streams)
        )
    )
)


;answer
(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
        (apply proc (map stream-car argstreams))
        (apply stream-map 
               (cons proc (map stream-cdr argstreams))))))