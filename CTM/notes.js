/*
 focus on programming concepts and the techniques to use them, not on programming languages.
  A computation model is a formal system that deﬁnes how computations
are done. 
Each computation model is based on a simple core language called its kernel
language.


The main
criterium is the creative extension principle.  Roughly, a new concept is added
when programs become complicated for technical reasons unrelated to the prob-
lem being solved.  Adding a concept to the kernel language can keep programs
simple, if the concept is chosen carefully.
We deﬁne programming, as a general human activity, to mean the act of extend-
ing or changing a system’s functionality. 
This book focuses on the construction of software systems.  In that setting,
programming is the step between the system’s speciﬁcation and a running pro-
gram that implements it.  The step consists in designing the program’s archi-
tecture and abstractions and coding them into a programming language.

 The kernel language approach shows one way.  In this approach, a
practical language is translated into a kernel language that consists of a small
number of programmer-signiﬁcant elements.   The rich set of abstractions and
syntax is encoded into the small kernel language.  This gives both programmer
and student a clear insight into what the language does. 



A wide variety of languages and programming paradigms can be modeled by
a small set of closely-related kernel languages. 
Reducing a complex phenomenon to its primitive elements is characteristic of
the scientiﬁc method.  It is a successful approach that is used in all the exact
sciences.  It gives a deep understanding that has predictive power.  For example,
structural science lets one design all bridges (whether made of wood, iron, both,
or anything else) and predict their behavior in terms of simple concepts such as
force, energy, stress, and strain, and the laws they obey

The kernel language approach combines features of all these approaches. A well-
designed kernel language covers a wide range of concepts, like a well-designed
multiparadigm language.  If the concepts are independent, then the kernel lan-
guage can be given a simple formal semantics, like a foundational calculus. Final-
ly, the formal semantics can be a virtual machine at a high level of abstraction.
This makes it easy for programmers to reason about programs.

The most diﬃcult work of programmers, and also the most rewarding,  is not
writing programs but rather designing abstractions.  We deﬁne an
abstraction loosely as a tool or device that solves a particular problem. Usually the
same abstraction can be used to solve many diﬀerent problems.  This versatility
is one of the key properties of abstractions.


The computation-based approach presents programming as a way to deﬁne
executions on machines. It grounds the student’s intuition in the real world
by means of actual executions on real systems.  This is especially eﬀective
with an interactive system: the student can create program fragments and
immediately see what they do. Reducing the time between thinking “what
if” and seeing the result is an enormous aid to understanding.  Precision
is not sacriﬁced, since the formal semantics of a program can be given in
terms of an abstract machine.

  The logic-based approach presents programming as a branch of mathemat-
ical logic.  Logic does not speak of execution but of program properties,
which is a higher level of abstraction.   Programs are mathematical con-
structions that obey logical laws.  The formal semantics of a program is
given in terms of a mathematical logic.  Reasoning is done with logical as-
sertions. The logic-based approach is harder for students to grasp yet it is
essential for deﬁning precise speciﬁcations of what programs do.


 Adding a concept to a computation model introduces new forms of expres-
sion, making some programs simpler, but it also makes reasoning about programs
harder. For example, by adding explicit state (mutable variables) to a functional
programming model we can express the full range of object-oriented programming
techniques.  However, reasoning about object-oriented programs is harder than
reasoning about functional programs.

Functional abstraction
 A list is actually a chain of links, where
each link contains two things: one list element and a reference to the rest of the
chain. 

自顶向下设计方法：
main function to solve the problem
write auxiliary functions
 Lazy evaluation
 Pascal’s triangle
 Higher-order programming
Exclusive-or lets us calculate the parity of each number in Pascal’s triangle
Concurrency
We would like our program to have several independent activities, each of which
executes at its own pace.  This is called concurrency.

What happens if an operation tries to use a variable that is not yet bound? From
a purely aesthetic point of view, it would be nice if the operation would simply
wait.  Perhaps some other thread will bind the variable, and then the operation
can continue.  This civilized behavior is known as dataﬂow. 

 This
illustrates  two  nice  properties  of dataﬂow.   First,  calculations  work  correctly
independent of how they are partitioned between threads.  Second, calculations
are patient: they do not signal errors, but simply wait.
Adding threads and delays to a program can radically change a program’s
appearance. But as long as the same operations are invoked with the same argu-
ments, it does not change the program’s results at all.  This is the key property
of dataﬂow concurrency.   This is why dataﬂow concurrency gives most of the
advantages of concurrency without the complexities that are usually associated
with it.

State
How can we let a function learn from its past? That is, we would like the function
to have some kind of internal memory, which helps it do its job. Memory is needed
for functions that can change their behavior and learn from their past. This kind
of memory is called explicit state. 

Functions with internal memory are usually called objects.
There is something special going on here: the cell is referenced by a local variable,
so it is completely invisible from the outside.  This property is called encapsulation.  It means that nobody can mess with the counter’s internals. 

 Inheritance means that a new class can be deﬁned in
terms of existing classes by specifying just how the new class is diﬀerent. 
 Nondeterminism exists because we lack knowledge of the exact
time when each basic operation executes. 
The content can be 1 because thread execution is interleaved.  That is, threads
take turns each executing a little. We have to assume that any possible interleav-
ing can occur. 

This leads us to a ﬁrst lesson for programming with state and concurrency: if
at all possible, do not use them together! It turns out that we often do not need
both together. When a program does need to have both, it can almost always be
designed so that their interaction is limited to a very small part of the program.

An operation is atomic if no
intermediate states can be observed.  It seems to jump directly from the initial
state to the result state.

The idea is to make sure that each thread body is atomic.  To do this,
we need a way to build atomic operations. We introduce a new language entity,
called lock, for this. A lock has an inside and an outside. The programmer deﬁnes
the instructions that are inside. A lock has the property that only one thread at
a time can be executing inside. If a second thread tries to get in, then it will wait
until the ﬁrst gets out. Therefore what happens inside the lock is atomic.

CH2 Declarative Computation Model
编程就是:
First, a computation model, which is a formal system that deﬁnes a lan-
guage and how sentences of the language (e.g., expressions and statements)
are executed by an abstract machine.  For this book, we are interested in
computation models that are useful and intuitive for programmers.  This
will become clearer when we deﬁne the ﬁrst one later in this chapter.

Second, a set of programming techniques and design principles used to write
programs in the language of the computation model.  We will sometimes
call this a programming model.  A programming model is always built on
top of a computation model.

Third,  a set of reasoning techniques  to let you  reason about programs,
to increase conﬁdence  that they behave correctly  and to calculate their
eﬃciency.

The ﬁrst and simplest computation model
we will study is declarative programming.  For now, we deﬁne this as evaluating
functions over partial data structures. This is sometimes called stateless program-
ming, as opposed to stateful programming (also called imperative programming)


 Deﬁning practical programming languages

 For programming languages,
‘sentences’ are usually called ‘statements’ and ‘words’ are usually called ‘tokens’.

 A program that
accepts a sequence of characters and returns a sequence of tokens is called a to-
kenizer or lexical analyzer.  A program that accepts a sequence of tokens and
returns a parse tree is called a parser.

A terminal symbol is simply a token. A nonterminal symbol represents
a sequence of tokens.  The nonterminal is deﬁned by means of a grammar rule,
which shows how to expand it into tokens.
<digit>   ::=   0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
<int>   ::=   <digit> { <digit> }
This rule says that an integer is a digit followed by zero or more digits.  The
braces “{ ... }” mean to repeat whatever is inside any number of times, including
zero.
How to read grammars:
•  Each terminal symbol encountered is added to the sequence.
•  For each nonterminal symbol encountered, read its grammar rule and replace the nonterminal by the sequence of tokens that it expands into.
•  Each time there is a choice (with |), pick any of the alternatives.



Context-free and context-sensitive grammars?
a nonterminal, e.g., hdigiti, is always the same no matter where it is used.
For most practical programming languages, there is usually no context-free
grammar that generates all legal programs and no others. For example, in many
languages a variable has to be declared before it is used.  This condition cannot
be expressed in a context-free grammar because the nonterminal that uses the
variable must only allow using already-declared variables.  This is a context de-
pendency.  A grammar that contains a nonterminal whose use depends on the
context where it is used is called a context-sensitive grammar.

Context-free grammars can be ambiguous, i.e., there can be several parse trees
that correspond to a given token sequence.
 A more convenient
approach is to add extra conditions. These conditions restrict the parser so that
only one parse tree is possible. We say that they disambiguate the grammar.

 解决歧义
 Precedence is a condition on an expression with diﬀerent operators, like
2*3+4.   Each operator is given a precedence level.   Operators with high
precedences are put as deep in the parse tree as possible, i.e., as far away
from the root as possible. If * has higher precedence than +, then the parse
tree (2*3)+4 is chosen over the alternative 2*(3+4).  If * is deeper in the
tree than +, then we say that * binds tighter than +.

Associativity is a condition on an expression with the same operator, like
2-3-4.  In this case, precedence is not enough to disambiguate because all
operators have the same precedence.  We have to choose between the trees
(2-3)-4 and 2-(3-4).  Associativity determines whether the leftmost or
the rightmost operator binds tighter. If the associativity of - is left, then
the tree (2-3)-4 is chosen. If the associativity of - is right, then the other
tree 2-(3-4) is chosen.


The  semantics  of a  language deﬁnes  what  a  program does  when  it executes.

The kernel language approach
First, deﬁne a very simple language, called the kernel language.  This lan-
guage should be easy to reason in and be faithful to the space and time
eﬃciency of the implementation.  The kernel language and the data struc-
tures it manipulates together form the kernel computation model.

Second, deﬁne a translation scheme from the full programming language
to the kernel language. Each grammatical construct in the full language is
translated into the kernel language. The translation should be as simple as
possible.  There are two kinds of translation, namely linguistic abstraction
and syntactic sugar. Both are explained below.

Linguistic abstraction
Both programming languages and natural languages can evolve to meet their
needs. When using a programming language, at some point we may feel the need
to extend the language, i.e., to add a new linguistic construct. For example, the
declarative model of this chapter has no looping constructs. Section 3.6.3 deﬁnes
a for  construct  to express  certain  kinds  of loops that are  useful  for writing
declarative programs. The new construct is both an abstraction and an addition
to the language syntax.  We therefore call it a linguistic abstraction. A practical
programming language consists of a set of linguistic abstractions.


 Some
languages leave the order of argument evaluation unspeciﬁed, but assume that a
function’s arguments are evaluated before the function. Other languages assume
that an argument is evaluated when and if its result is needed, not before.

Linguistic abstractions are useful for more than just increasing the expressive-
ness of a program.  They can also improve other properties such as correctness,
security, and eﬃciency. By hiding the abstraction’s implementation from the pro-
grammer, the linguistic support makes it impossible to use the abstraction in the
wrong way. The compiler can use this information to give more eﬃcient code.

The kernel language approach is an example of a translation approach to seman-
tics, i.e., it is based on a translation from one language to another. 
The machine approach is intended for the implementor. Programs are trans-
lated into an idealized machine, which is traditionally called an abstract
machine or a virtual machine.3   It is relatively easy to translate idealized
machine code into real machine code.
解释器
 An interpreter is a pro-
gram written in language L1  that accepts programs written in another language
L2  and executes them. This approach is used by Abelson & Sussman [2]. In their
case, the interpreter is metacircular, i.e., L1  and L2  are the same language L.
Adding new language features, e.g., for concurrency and lazy evaluation, gives a
new language L0  which is implemented by extending the interpreter for L.

The single-assignment store
A store where all variables are bound to values is called a value store.
 A value is a mathematical constant.

Variables in the single-assignment store are called declarative variables. 
Once bound, a declarative variable stays bound throughout the computation
and is indistinguishable from its value. 

 why
we are introducing a single-assignment store, when other languages get by with
a value store or a cell store(可以被修改).

The basic operation on a store is binding a variable to a newly-created value. We
will write this as xi=value. Here xi  refers directly to a variable in the store (and
is not the variable’s textual name in a program!) and value refers to a value

The single-assignment operation xi=value constructs value in the store and then
binds the variable xi  to this value. If the variable is already bound, the operation
will test whether the two values are compatible.  If they are not compatible, an
error is signaled

So far, we have looked at a store that contains variables and values, i.e., store
entities, with which calculations can be done.  It would be nice if we could refer
to a store entity from outside the store.  This is the role of variable identiﬁers.

A variable identiﬁer is a textual name that refers to a store entity from outside
the store.   The mapping from variable identiﬁers to store entities is called an
environment.
Following
the links of bound variables to get the value is called dereferencing. It is invisible
to the programmer.
兼容
 We say a set of partial values is compatible if the unbound variables in
them can be bound in such a way as to make them all equal.   For example,
person(age:25) and person(age:x) are compatible (because x can be bound
to 25), but person(age:25) and person(age:26) are not.
 Dataﬂow variables
In the declarative model, creating a variable and binding it are done separately.
What happens if we try to use the variable before it is bound?  We call this a
variable use error. Some languages create and bind variables in one step, so that
use errors cannot occur. This is the case for functional programming languages.
Other languages allow creating and binding to be separate. 
Declarative variables that cause the program to wait until they are bound are
called dataﬂow variables. The declarative model uses dataﬂow variables because
they are tremendously useful in concurrent programming
i.e., for programs with
activities that run independently.  If we do two concurrent operations, say A=23
and B=A+1, then with the fourth solution this will always run correctly and give
the answer B=24. It doesn’t matter whether A=23 is tried ﬁrst or whether B=A+1
is tried ﬁrst. With the other solutions, there is no guarantee of this. This property
of order-independence makes possible the declarative concurrency of Chapter 4.
It is at the heart of why dataﬂow variables are a good idea.

Kernel language

Values and types
A type or data type is a set of values together with a set of operations on those
values. 
ADT
programs can deﬁne their own types, which are
called abstract data types, ADT for short

There are two basic approaches to typing, namely dynamic and static typing. In
static typing, all variable types are known at compile time.  In dynamic typing,
the variable type is known only when the variable is bound.   The declarative
model is dynamically typed. The compiler tries to verify that all operations use
values of the correct type. But because of dynamic typing, some type checks are
necessarily left for run time.

An atom is a kind of symbolic constant that can be used as a
single element in calculations. 

Power of Record
Records are the basic way to structure data.  They are the building blocks of
most data structures, including lists, trees, queues, graphs, etc

Procedures are more appropriate than objects because they are simpler. Ob-
jects are actually quite complicated, as Chapter 7 explains. Procedures are more
appropriate than functions because they do not necessarily deﬁne entities that
behave like mathematical functions.6   For example, we deﬁne both components
and objects as abstractions based on procedures. In addition, procedures are ﬂex-
ible because they do not make any assumptions about the number of inputs and
outputs.  A function always has exactly one output.  A procedure can have any
number of inputs and outputs, including zero. We will see that procedures are ex-
tremely powerful building blocks, when we talk about higher-order programming
in Section 3.6.

Kernel language semantics

 The meaning of an identiﬁer like X is determined
by the innermost local  statement that declares X. 

This scoping rule is
called lexical scoping or static scoping. 

call by reference
取过程定义时候的值，而不是执行时候的值
It has to
be the value of Y when the procedure is deﬁned. 

local  P  Q  in
  proc  {Q  X}  {Browse  stat(X)}  end
  proc  {P  X}  {Q  X}  end
  local  Q  in
    proc  {Q  X}  {Browse  dyn(X)}  end
    {P  hello}
  end
end

Static scoping.  A procedure can have external references, which are free
identiﬁers in the procedure body that are not declared as arguments.  LB
has one external reference. Max has none. The value of an external reference
is its value when the procedure is deﬁned.  This is a consequence of static
scoping.

 Which default is better?
The correct default is procedure values with static scoping.  This is because a
procedure that works when it is deﬁned will continue to work, independent of
the environment where it is called.  This is an important software engineering
property.
Dynamic scoping remains useful in some well-deﬁned areas.   For example,
consider the case of a procedure whose code is transferred across a network from
one computer to another. Some of this procedure’s external references, for exam-
ple calls to common library operations, can use dynamic scoping.  This way, the
procedure will use local code for these operations instead of remote code. This is
much more eﬃcient.

存在unbound variables时
 We decide that the program will simply stop its execution, with-
out signaling any kind of error.  If some other activity (to be determined later)
binds Y then the stopped execution can continue as if nothing had perturbed the
normal ﬂow of execution.  This is called dataﬂow behavior.  Dataﬂow behavior
underlies a second powerful tool presented in this book, namely concurrency. In
the semantics, we will see that dataﬂow behavior can be implemented in a simple
way.


Bound identiﬁer occurrences and bound variables
Do  not  confuse  a  bound  identiﬁer  occurrence  with  a
bound variable!  A bound identiﬁer occurrence does not
exist at run time; it is a textual variable name that tex-
tually occurs inside a construct that declares it (e.g., a
procedure or variable declaration). A bound variable ex-
ists at run time; it is a dataﬂow variable that is bound
to a partial value.

local  Arg1  Arg2  in
  Arg1=111*111
  Arg2=999*999
  Res=Arg1+Arg2
end
In this statement, all variable identiﬁers are declared with lexical scoping.  The
identiﬁer occurrences Arg1 and Arg2 are bound and the occurrence Res is free.
This statement cannot be run. To make it runnable, it has to be part of a bigger
statement that declares Res.


闭包
The statement hsi can have free variable identiﬁers. Each free identifer is either a
formal parameter or not. The ﬁrst kind are deﬁned anew each time the procedure
is called. They form a subset of the formal parameters {<y>1, ..., <y>n}. The second
kind are deﬁned once and for all when the procedure is declared.  We call them
the external references of the procedure.

Deﬁning practical programming languages
sequence of characters --> Tokenizer -->sequence of
tokens --> Parser --> parse tree representing a statement

This section sets the stage for the rest of the book by explaining how we
will present the syntax (“grammar”) and semantics (“meaning”) of practical pro-
gramming languages.  With this foundation we will be ready to present the ﬁrst
computation model of the book, namely the declarative computation model. We
will continue to use these techniques throughout the book to deﬁne computation
models.

 Suspendable statements
 statement执行时，遇到unbound变量会等待unbound变量bind
 后再执行
 并行编程：
  A suspended stack ST can become runnable again if another stack
does an operation that makes ST’s activation condition true. In that chapter we
shall see that communication from one stack to another through the activation
condition is the basis of dataﬂow execution. 


外部变量引用：
local  LowerBound  Y  C  in
  Y=5
  proc  {LowerBound  X  ?Z}
    if  X>=Y  then  Z=X  else  Z=Y  end
  end
  {LowerBound  3  C}
end

local  Y  in
  Y=10
  {LowerBound  3  C}
end
The calling environment has changed slightly: Y refers to a new variable y0, which
is bound to 10.  When doing the application, the new environment is calculated
in exactly the same way as before, starting from the contextual environment and
adding the formal arguments. This means that the y0  is ignored! We get exactly
the same situation as before in the semantic stack
The store still has the binding y0 = 10. But y0  is not referenced by the semantic
stack, so this binding makes no diﬀerence to the execution.

可以理解为定义时的context就确定了吗?

