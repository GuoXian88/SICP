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

 In the declarative model, functions are eager by default, i.e., function arguments are evaluated before the function body is executed. This is also called
strict evaluation.  The functional languages Scheme and Standard ML are
strict.  There is another useful execution order, lazy evaluation, in which function arguments are evaluated only if their result is needed. 


A table that remembers previous calls so that they can be
avoided in the future is called a memoization table.

??
local  X  Y  Z  in
  f(X  b)=f(a  Y)
  f(Z  a)=Z
  {Browse  [X  Y  Z]}
end

Entailment and disentailment checks (the == and \= operations)
•  It returns the value true if the graphs starting from the nodes of X and Y
have the same structure, i.e., all pairwise corresponding nodes have identical
values or are the same node. We call this structure equality.
•  It returns the value false if the graphs have diﬀerent structure, or some
pairwise corresponding nodes have diﬀerent values.
•  It blocks when it arrives at pairwise corresponding nodes that are diﬀerent,
but at least one of them is unbound.


Dynamic and static typing
It is important for a language to be strongly-typed, i.e., to have a type system
that is enforced by the language. 

In a statically-typed language, on the other hand, all variable
types are known at compile time. The type can be declared by the programmer or
inferred by the compiler. When designing a language, one of the major decisions
to make is whether the language is to be dynamically typed, statically typed, or
some mixture of both.



The basic principle is that static typing puts restrictions on
what programs one can write, reducing expressiveness of the language in return
for giving advantages such as improved error catching ability, eﬃciency, security,
and partial program veriﬁcation. 

•  Dynamic typing puts no restrictions on what programs one can write. To be
precise, all syntactically-legal programs can be run. Some of these programs
will raise exceptions, possibly due to type errors, which can be caught by
an exception handler.  Dynamic typing gives the widest possible variety of
programming techniques.  The increased ﬂexibility is felt quite strongly in
practice. The programmer spends much less time adjusting the program to
ﬁt the type system.
•  Dynamic typing makes it a trivial matter to do separate compilation, i.e.,
modules can be compiled without knowing anything about each other. This
allows truly open programming, in which independently-written modules
can come together at run time and interact with each other. It also makes
program development scalable, i.e., extremely large programs can be divided
into modules that can be compiled individually without recompiling other
modules. This is harder to do with static typing because the type discipline
must be enforced across module boundaries.
•  Dynamic  typing  shortens  the  turnaround  time  between  an  idea  and  its
implementation.  It enables an incremental development environment that
is  part of the run-time  system.   It  allows  to test programs  or program
fragments even when they are in an incomplete or inconsistent state.
•  Static typing allows to catch more program errors at compile time.  The
static type declarations are a partial speciﬁcation of the program, i.e., they
specify part of the program’s behavior.  The compiler’s type checker veri-
ﬁes that the program satisﬁes this partial speciﬁcation.  This can be quite
powerful.   Modern static type systems can catch a surprising number of
semantic errors.
•  Static typing allows a more eﬃcient implementation. Since the compiler has
more information about what values a variable can contain, it can choose a
more eﬃcient representation. For example, if a variable is of boolean type,
the compile can implement it with a single bit.   In a dynamically-typed
language, the compiler cannot always deduce the type of a variable. When
it cannot, then it usually has to allocate a full memory word, so that any
possible value (or a pointer to a value) can be accommodated.
•  Static typing can improve the security of a program. Secure ADTs can be
constructed based solely on the protection oﬀered by the type system.


Each approach has a role in practical application development.  Static typ-
ing is recommended when the programming techniques are well-understood and
when eﬃciency and correctness are paramount. Dynamic typing is recommended
for rapid development and when programs must be as ﬂexible as possible, such
as application prototypes, operating systems, and some artiﬁcial intelligence ap-
plications.

CH3 Declarative Programming Techniques

Declarative programs are compositional.
Reasoning about declarative programs is simple

We start by looking more closely at the ﬁrst property.  Let us deﬁne a com-
ponent as a precisely delimited program fragment with well-deﬁned inputs and
outputs. A component can be deﬁned in terms of a set of simpler components. For
example, in the declarative model a procedure is one kind of component.  The
application program is the topmost component in a hierarchy of components.
The hierarchy bottoms out in primitive components which are provided by the
system.

The basic technique for writing declarative programs is to consider the pro-
gram as a set of recursive function deﬁnitions, using higher-orderness to simplify
the program structure. 


A recursive function is one whose deﬁnition body refers
to the function itself, either directly or indirectly.  Direct recursion means that
the function itself is used in the body. Indirect recursion means that the function
refers to another function that directly or indirectly refers to the original function.
Higher-orderness means that functions can have other functions as arguments and
results. This ability underlies all the techniques for building abstractions that we
will show in the book.  Higher-orderness can compensate somewhat for the lack
of expressiveness of the declarative model, i.e., it makes it easy to code limited
forms of concurrency and state in the declarative model.

 Intuitively, it is programming by deﬁning the what (the
results we want to achieve) without explaining the how (the algorithms, etc., need-
ed to achieve the results).


A descriptive declarativeness.如html, xml
 A programmable declarativeness.
There are two fundamentally diﬀerent ways to view programmable declarative-
ness:
•  A deﬁnitional view, where declarativeness is a property of the component
implementation.  For example, programs written in the declarative model
are guaranteed to be declarative, because of properties of the model.
•  An observational view, where declarativeness is a property of the component
interface. The observational view follows the principle of abstraction: that
to use a component it is enough to know its speciﬁcation without knowing
its implementation.  The component just has to behave declaratively, i.e.,
as if it were independent, stateless, and deterministic, without necessarily
being written in a declarative computation model.


Two styles of deﬁnitional declarative programming have become particularly
popular:  the functional and the logical.  In the functional style, we say that a
component deﬁned as a mathematical function is declarative.   Functional lan-
guages such as Haskell and Standard ML follow this approach.  In the logical
style, we say that a component deﬁned as a logical relation is declarative.  Log-
ic languages such as Prolog and Mercury follow this approach.  It is harder to
formally manipulate functional or logical programs than descriptive programs,
but they still follow simple algebraic laws.

 Practically, declarative programs are very much like other programs: they
require algorithms, data structures, structuring, and reasoning about the order of
operations. This is because declarative languages can only use mathematics that
can be implemented eﬃciently.  There is a trade-oﬀ between expressiveness and
eﬃciency. Declarative programs are usually a lot longer than what a speciﬁcation
could be. So the distinction between speciﬁcation and implementation still makes
sense, even for declarative programs.


 The basic principle is that a helper routine deﬁned only
as an aid to deﬁne another routine should not be visible elsewhere.
Putting them inside (Figures 3.6 and 3.7) lets them see the arguments of
the main routines as external references, according to the lexical scoping
rule (see Section 2.4.3).  Therefore, they need fewer arguments.  But each
time the main routine is invoked, new helper routines are created.  This
means that new procedure values are created.

Putting them outside (Figures 3.4 and 3.5) means that the procedure values
are created once and for all, for all calls to the main routine. But then the helper routines need more arguments so that the main routine can pass
information to them.


fun  {Iterate  S  IsDone  Transform}
  if  {IsDone  S}  then  S
  else  S1  in
    S1={Transform  S}
    {Iterate  S1  IsDone  Transform}
  end
end


Recursive computation
In programming, recursion
occurs in two major ways:  in functions and in data types.  
A data type is recursive if it is deﬁned in terms of
itself.  For example, a list is deﬁned in terms of a smaller list.


We saw that an iterative computation has a constant stack size.  This is not
always the case for a recursive computation. Its stack size may grow as the input
grows.  Sometimes this is unavoidable, e.g., when doing calculations with trees,
as we will see later.  In other cases, it can be avoided.  An important part of
declarative programming is to avoid a growing stack size whenever possible. 


As before, we see that the stack grows by one statement per call. We summarize
the diﬀerences between the two versions of the abstract machine:
•  The environment-based abstract machine, deﬁned in Chapter 2, is faithful
to the implementation on a real computer, which uses environments. How-
ever, environments introduce an extra level of indirection, so they are hard
to use for hand calculation.
•  The substitution-based abstract machine is easier to use for hand calcu-
lation,  because there are many fewer symbols to manipulate.   However,
substitutions are costly to implement, so they are generally not used in a
real implementation.

 Converting a recursive to an iterative computation

fun  {Fact  N}
  if  N==0  then  1
  elseif  N>0  then  N*{Fact  N-1}
  else  raise  domainError  end
  end
end

fun  {Fact  N}
  fun  {FactIter  N  A}
    if  N==0  then  A
    elseif  N>0  then  {FactIter  N-1  A*N}
    else  raise  domainError  end
    end
  end
in
  {FactIter  N  1}
end

The function that does the iteration, FactIter, has a second argument A. This
argument is crucial; without it an iterative factorial is impossible.  The second
argument is not apparent in the simple mathematical deﬁnition of factorial we
used ﬁrst. We had to do some reasoning to bring it in.


 Programming with recursion

 Type notation
 The list type is a subset of the record type.  There are other useful subsets of
the record type, e.g., binary trees. 
A list Xs is either nil or X|Xr where Xr is a list. Other subsets of the record
type are also useful.  For example, a binary tree can be deﬁned as leaf(key:K
value:V) or tree(key:K  value:V  left:LT  right:RT) where LT and RT are
both binary trees. 

<List T>   ::=   T ´|´ <List T>
|   nil

<BTree T>   ::=   tree(key: <Literal> value: T
left: <BTree T> right: <BTree T>)
|   leaf(key: <Literal> value: T)

 Here are some cases where the notation is not good enough:
•  The notation cannot deﬁne the positive integers, i.e., the subset of hInti
whose elements are all greater than zero.
•  The notation cannot deﬁne sets of partial values.  For example, diﬀerence
lists cannot be deﬁned.

