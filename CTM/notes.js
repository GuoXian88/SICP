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
a sequence of tokens. 


Context-free and context-sensitive grammars?