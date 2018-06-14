;self

;answer
assuming procedure try can halt, when execute (try try), (halt? try try) will be true, but the procedure will run forever. if procedure try can't halt. (halt? try try) will be false, but the procedure will halt.