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


 Last call optimization

 尾递归: 递归过程只有一个递归调用并且是过程里面最后的调用
 只保留内层函数的调用记录。如果所有函数都是尾调用，那么完全可以做到每次执行时，调用记录只有一项，这将大大节省内存。这就是"尾调用优化"的意义

Active memory and memory management
proc  {Loop10  I}
  if  I==10  then  skip
  else
    {Browse  I}
    {Loop10  I+1}
  end
end

 The semantic stack is bounded by a constant size. On the other hand,
the store grows bigger at each call. 

A partial value is reachable if it is referenced by a statement on
the semantic stack or by another reachable partial value. The semantic stack and
the reachable part of the store are together called the active memory. The rest
of the store can safely be reclaimed, i.e., the memory it uses can be reused for
other purposes. Since the active memory size of the Loop10 example is bounded
by a small constant, it can loop indeﬁnitely without exhausting system memory.
Each block of mem-
ory continuously cycles through three states: active, inactive, and free. Memory
management is the task of making sure that memory circulates correctly along
this cycle. 

•  If it can determine  this directly,  then it deallocates this memory.   This
makes it immediately become free again.  This is what happens with the
semantic stack in the Loop10 example.
•  If it cannot determine this directly, then the memory becomes inactive. It is
simply no longer reachable by the running program. This is what happens
with the store in the Loop10 example.

 Reclaiming inactive
memory is the hardest part of memory management, because recognizing that
memory is unreachable is a global condition.
It depends on the whole execution
state of the running program. 
Dangling reference. This happens when a block is reclaimed even though it
is still reachable. 
 Memory leak. This happens when an unreachable block is considered as still
reachable, and so is not reclaimed.  

A typical garbage collector has two phases.  In the ﬁrst phase, it determines
what the active memory  is.   It does this ﬁnding all data structures  that are
reachable starting from an initial set of pointers called the root set. The root set
is the set of pointers that are always needed by the program.  In the abstract
machine deﬁned so far, the root set is simply the semantic stack. In general, the
root set includes all pointers in ready threads and all pointers in operating system
data structures.   We will see this when we extend the machine to implement
the new concepts introduced in later chapters.  The root set also includes some
pointers related to distributed programming (namely references from remote sites;
see Chapter 11).

In the second phase, the garbage collector compacts the memory. That is, it
collects all the active memory blocks into one contiguous block (a block without
holes) and the free memory blocks into one contiguous block.

There are two cases that remain
the developer’s  responsibility:  avoiding memory  leaks and managing external
resources.


fun  {Sum  X  L1  L}
  case  L1  of  Y|L2  then  {Sum  X+Y  L2  L}
  else  X  end
end
{Browse  {Sum  0  L  L}}

Sum sums the elements of a list.  But it also keeps a reference to L, the original
list, even though it does not need L. This means L will stay in memory during
the whole execution of Sum. 

A well-written program therefore has to do some “cleanup” after itself: making
sure that it no longer references data structures that it no longer needs. 

The ﬁrst case is when a Mozart data structure refers to an external resource.
For example, a record can correspond to a graphic entity in a graphics display or
to an open ﬁle in a ﬁle system. If the record is no longer needed, then the graphic
entity has to be removed or the ﬁle has to be closed.  Otherwise, the graphics
display or the ﬁle system will have a memory leak. This is done with a technique
called ﬁnalization, which deﬁnes actions to be taken when data structures become
unreachable. Finalization is explained in Section 6.9.2.
The second case is when an external resource needs a Mozart data structure.
This is often straightforward to handle.  For example, consider a scenario where
the Mozart program implements a database server that is accessed by external
clients.  This scenario has a simple solution:  never do automatic reclaiming of
the database storage. Other scenarios may not be so simple.  A general solution
is to set aside a part of the Mozart program to represent the external resource.
This part should be active (i.e., have its own thread) so that it is not reclaimed
haphazardly. It can be seen as a “proxy” for the resource. The proxy keeps a ref-
erence to the Mozart data structure as long as the resource needs it. The resource
informs the proxy when it no longer needs the data structure.

 From kernel language to practical language

An expression is syntactic sugar for a sequence of operations that returns a value.
It is diﬀerent from a statement, which is also a sequence of operations but does
not return a value. 

proc  {F  X1  ...  XN  ?R}  <statement>  R=<expression> end

Ys={F  X}|{Map  Xr  F}
In this case, the translation puts the nested calls after the bind operation:
local  Y  Yr  in
  Ys=Y|Yr
  {F  X  Y}
  {Map  Xr  F  Yr}
end
This ensures that the recursive call is last.

 An independently-executing
instruction sequence is called a thread. Programming with more than one thread
is called concurrent programming

 Exceptions
The program should not stop when they occur. Rather, it should in a controlled
way transfer execution to another part, called the exception handler, and pass
the exception handler a value that describes the error.
 programs are built in layered fasion.   Then the
error conﬁnement principle states that an error in a component should
be catchable at the component boundary.

 The try state-
ment creates an exception-catching context together with an exception handler.
The raise statement jumps to the boundary of the innermost exception-catching
context and invokes the exception handler there.  Nested try statements create
nested contexts.

Advanced topics

 In the declarative model, functions are eager by default, i.e., function argu-
ments are evaluated before the function body is executed. This is also called
strict evaluation.  The functional languages Scheme and Standard ML are
strict.  There is another useful execution order, lazy evaluation, in which function arguments are evaluated only if their result is needed. 


A table that remembers previous calls so that they can be
avoided in the future is called a memoization table.
