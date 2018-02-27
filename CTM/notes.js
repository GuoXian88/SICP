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

