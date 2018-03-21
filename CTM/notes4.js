/*

local  Wrap  Unwrap  in
    {NewWrapper  Wrap  Unwrap}
    fun  {NewStack}  {Wrap  nil}  end
    fun  {Push  S  E}  {Wrap  E|{Unwrap  S}}  end
    fun  {Pop  S  E}
        case  {Unwrap  S}  of  X|S1  then  E=X  {Wrap  S1}  end
    end
    fun  {IsEmpty  S}  {Unwrap  S}==nil  end
end

 Lexical scoping guarantees that wrapping
and unwrapping are only possible inside the stack implementation.  Namely, the
identiﬁers Wrap and Unwrap are only visible inside the local statement. Outside
this scope, they are hidden.  Because Unwrap is hidden, there is absolutely no
way to see inside a stack value.  Because Wrap is hidden, there is absolutely no
way to “forge” stack values.

Protecting unbound variables
One solution is to have a restricted version of the variable that
can only be read, not bound.  We call this a read-only view of a variable.


In the abstract machine, read-only views sit in a new store called the read-
only store.  We modify the bind operation so that before binding a variable to
a determined value, it checks whether the variable is in the read-only store.  If
so, the bind suspends.  When the variable becomes determined, then the bind
operation can continue.

 There are basically two approaches to create names
that are globally unique:
•  The centralized approach. There is a name factory somewhere in the world.
To get a fresh name, you need to send a message to this factory and the reply
contains a fresh name.  The name factory does not have to be physically
in one place;  it can be spread out over many computers.   For example,
the IP protocol supposes a unique IP address for every computer in the
world that is connected to the Internet. IP addresses can change over time,
though, e.g., if network address translation is done or dynamic allocation of
IP addresses is done using the DHCP protocol.  We therefore complement
the IP address with a high-resolution timestamp giving the creation time
of NewName. This gives a unique constant that can be used to implement a
local name factory on each computer.
•  The decentralized approach.  A fresh name is just a vector of random bits.
The random bits are generated by an algorithm that depends on enough
external information so that diﬀerent computers will not generate the same
vector.  If the vector is long enough, then the that names are not unique
will be arbitrarily small.  Theoretically, the probability is always nonzero,
but in practice this technique works well.

 A secure declarative dictionary

local
    Wrap  Unwrap
    {NewWrapper  Wrap  Unwrap}
    %  Previous  definitions:
    fun  {NewDictionary2}  ...  end
    fun  {Put2  Ds  K  Value}  ...  end
    fun  {CondGet2  Ds  K  Default}  ...  end
    fun  {Domain2  Ds}  ...  end
in
    fun  {NewDictionary}
        {Wrap  {NewDictionary2}}
    end
    fun  {Put  Ds  K  Value}
        {Wrap  {Put2  {Unwrap  Ds}  K  Value}}
    end
    fun  {CondGet  Ds  K  Default}
        {CondGet2  {Unwrap  Ds}  K  Default}
    end
    fun  {Domain  Ds}
        {Domain2  {Unwrap  Ds}}
    end
end

 Capabilities and security
 To implement a security policy, a
system uses security mechanisms. Throughout this book, we will discuss security
mechanisms that are part of a programming language, such as lexical scoping
and names.  We will ask ourselves what properties a language must possess in
order  to build  secure  programs,  that  is,  programs  that  can  resist  attacks  by
adversaries that stay within the language.

The protection techniques we have introduced to make secure abstract data types
are special cases of a security concept called a capability.

Principle of least privilege

 Nondeclarative needs
 Declarative programming, because of its “pure functional” view of programming,
is somewhat detached from the real world, in which entities have memories (state)
and can evolve independently and proactively (concurrency). To connect a declar-
ative program to the real world, some nondeclarative operations are needed. This
section talks about two classes of such operations:  ﬁle I/O (input/output) and
graphical user interfaces.

declare  [File]={Module.link  [´File.ozf´]}
Remember that "foo.txt" is a string (a list of character codes) and ´foo.txt´
is an atom (a constant with a print representation). 

Mozart has other operations that allow to read a ﬁle either incrementally or
lazily, instead of all at once. This is important for very large ﬁles that do not ﬁt
into the memory space of the Mozart process. 

The module File provides three operations:  File.writeOpen to
open the ﬁle, which must be done ﬁrst, File.write to append a string to the
ﬁle, and File.writeClose to close the ﬁle, which must be done last. 

 Stateless data I/O with ﬁles

 Program design in the small
 This step is called program design.   It starts
from a problem we want to solve (usually explained in words, sometimes not very
precisely) gives the high-level structure of the program, i.e., what programming
techniques we need to use and how they are connected together, and ends up
with a complete program that solves the problem.

We recommend the following design methodology,
which is a mixture of creativity and rigorous thinking:
•  Informal speciﬁcation. We start by writing down as precisely as we can
what the program should do:  what it’s inputs and outputs are and how
the outputs relate to the inputs.   This description is called an informal
speciﬁcation.  Even though it is precise, we call it “informal” because it is
written in English.  “Formal” speciﬁcations are written in a mathematical
notation.
•  Examples.  To make the speciﬁcation perfectly clear, it is always a good
idea to imagine examples of what the program does in particular cases. The examples should “stress” the program:  use it in boundary conditions and
in the most unexpected ways we can imagine.
•  Exploration.  To ﬁnd out what programming techniques we will need, a
good way is to use the interactive interface to experiment with program
fragments.  The idea is to write small operations that we think might be
needed for the program.  We use the operations that the system already
provides as a basis. This step gives us a clearer view of what the program’s
structure should be.
•  Structure and coding. Now we can lay out the program’s structure. We
make a rough outline of the operations needed to calculate the outputs from
the inputs and how they ﬁt together. We then ﬁll in the blanks by writing
the actual program code. The operations should be simple: each operation
should do just one thing.  To improve the structure we can group related
operations in modules.
•  Testing  and  reasoning.   Finally,  we  have to verify  that our program
does the right thing.   We try it on a series of test cases,  including the
examples we came up with before.   We correct errors until the program
works well. We can also reason about the program and its complexity, using
the formal semantics for parts that are not clear. Testing and reasoning are
complementary: it is important to do both to get a high-quality program.


 A better way is to partition
the program into logical units, each of which implements a set of operations that
are related in some way.  Each logical unit has two parts, an interface and an
implementation. 
 Only the interface is visible from outside the logical unit.  A
logical unit may use others as part of its implementation.


We call module a part of a program that groups together related operations into
an entity that has an interface and an implementation.   In this book, we will
implement modules in a simple way:
•  The module’s interface is a record that groups together related language en-
tities (usually procedures, but anything is allowed including classes, objects,
etc.).
•  The module’s implementation is a set of language entities that are accessible
by the interface operations but hidden from the outside. The implementa-
tion is hidden using lexical scoping.

A
module speciﬁcation is a kind of template that creates a module each time it is
instantiated.  A module speciﬁcation is sometimes called a software component.
 To avoid any confusion in this book, we will call our module
speciﬁcations functors. A functor is a function whose arguments are the modules
it needs and whose result is a new module.

 (To be precise, the functor takes
module interfaces as arguments, creates a new module, and returns that module’s
interface!) 
 A functor has three parts:  an import part, which
speciﬁes what other modules it needs, an export part, which speciﬁes the module
interface, and a define parts, which gives the module implementation including
its initialization code.

a functor
creates a new module in three steps.  First, the modules it needs are identiﬁed.
Second, the initialization code is executed. Third, the module is loaded the ﬁrst
time it is needed during execution.   This technique is called dynamic linking,
as opposed to static linking, in which the modules are loaded when execution
starts.  At any time, the set of currently installed modules is called the module
environment.

CH 4 Declarative Concurrency

Concurrency is essential for programs that
interact with their environment, e.g., for agents, GUI programming, OS interac-
tion, and so forth.

Concurrency also lets a program be organized into parts that
execute independently and interact only when needed, i.e., client/server and pro-
ducer/consumer programs. This is an important software engineering property.

It is based on the fact that a dataﬂow variable can
be bound to only one value. This gives the following two consequences:
•  What stays the same: The result of a program is the same whether or not it
is concurrent. Putting any part of the program in a thread does not change
the result.
•  What is new:  The result of a program can be calculated incrementally.  If
the input to a concurrent program is given incrementally, then the program
will calculate its output incrementally as well.

In the concurrent version, Gen and Map both execute simultaneously.  Whenever
Gen adds an element to its list, Map will immediately calculate its square.  The
result is displayed incrementally, as the elements are generated, one element each
tenth of a second.

 The data-driven concurrent model
A thread is simply an executing statement, i.e.,a semantic stack. 
The second step extends the model with another execution order. We add
triggers and the single instruction {ByNeed  P  X}.

Interleaving
We will use the interleaving semantics throughout the book. Whatever the par-
allel execution is, there is always at least one interleaving that is observationally
equivalent to it.  That is, if we observe the store during the execution, we can
always ﬁnd an interleaving execution that makes the store evolve in the same
way.
Two steps in this partial order are causally ordered if the ﬁrst
binds a dataﬂow variable X and the second needs the value of X.

Nondeterminism
In a declarative concurrent model, the nondeterminism is not visible to the
programmer.1   There are two reasons for this.  First, dataﬂow variables can be
bound to only one value.  The nondeterminism aﬀects only the exact moment
when each binding takes place; it does not aﬀect the plain fact that the binding
does take place. Second, any operation that needs the value of a variable has no
choice but to wait until the variable is bound.

We say the system is fair if it does not let any ready thread “starve”, i.e.,
all ready threads will eventually execute. This is an important property to make
program behavior predictable and to simplify reasoning about programs.  It is
related to modularity: fairness implies that a thread’s execution does not depend
on that of any other thread, unless the dependency is programmed explicitly. In
the rest of the book, we will assume that threads are scheduled fairly.

The choice of which ST to select is done by the scheduler according to a
well-deﬁned set of rules called the scheduling algorithm.  This algorithm
is careful to make  sure that good properties,  e.g.,  fairness,  hold of any
computation.  A real scheduler has to take much more than just fairness
into account. 

Memory management
Memory management is extended to the multiset as follows:
•  A terminated semantic stack can be deallocated.
•  A blocked semantic stack can be reclaimed if its activation condition depends on an unreachable variable.  In that case, the semantic stack would never become runnable again, so removing it changes nothing during the execution.



CH4 Declarative Concurrency
Concurrency also lets a program be organized into parts that
execute independently and interact only when needed, i.e., client/server and pro-
ducer/consumer programs. This is an important software engineering property.
It is based on the fact that a dataﬂow variable can
be bound to only one value. This gives the following two consequences:
1.What stays the same: The result of a program is the same whether or not it
is concurrent. Putting any part of the program in a thread does not change
the result.
2.What is new:  The result of a program can be calculated incrementally.  If
the input to a concurrent program is given incrementally, then the program
will calculate its output incrementally as well.

thread  Xs={Gen  1  10}  end
thread  Ys={Map  Xs  fun  {$  X}  X*X  end}  end
{Browse  Ys}
Whenever
Gen adds an element to its list, Map will immediately calculate its square.

data-driven concurrency
Lazy execution.  This part explains the second form of declarative con-
currency, namely demand-driven concurrency, also known as lazy execution.eg:
lazy streams and list comprehensions.




 */