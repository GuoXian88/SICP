;self


;answer
this won't work. because, in (let ((a <e1>) (b <e2>))), when compute e2, it depends y, but we only have a not y. For the same reason, the solution in text will work. 

I think both method will work, because (eval "dy") is 'delayed'.