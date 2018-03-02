/*
( proc { $ <y>1  ... <y>n} <s> end,   CE )

Here CE (the contextual environment) is E|{hzi1
,...,hzin}
, where E is the environ-
ment when the procedure is declared.  This pair is put in the store just like any
other value.
Because it contains an environment as well as a procedure deﬁnition, a pro-
cedure value is often called a closure or a lexically-scoped closure. This is because
it “closes” (i.e., packages up) the environment at procedure deﬁnition time. This
is also called environment capture.  When the procedure is called, the contextu-
al environment is used to construct the environment of the executing procedure
body.


  The statements should simply
wait until hxi is bound. We say that they are suspendable statements. They have
an activation condition, which is a condition that must be true for execution
to continue.  The condition is that E(hxi) must be determined, i.e., bound to a
number, record, or procedure.
In Chapter 4, when we
introduce concurrent programming, we will have executions with more than one
semantic stack. A suspended stack ST can become runnable again if another stack
does an operation that makes ST’s activation condition true. In that chapter we
shall see that communication from one stack to another through the activation
condition is the basis of dataﬂow execution.


Declaring more than one variable in a local declaration. This is translated
into nested local declarations.


