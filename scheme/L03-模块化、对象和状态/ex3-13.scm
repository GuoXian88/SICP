;self



;answer

ASCII like it's 1985


;  ,-------------------,
;  |                   |
;  v                   |
; ( . ) -> ( . ) -> ( . )
;  |        |        |
;  v        v        v
;  'a       'b       'c


procedure make-circle will make a circular list. The cdr of last cell of the list, instead of pointing to nil points to the first cell of the list. if we try to compute (last-pair z) will produce infinite recursion. 
