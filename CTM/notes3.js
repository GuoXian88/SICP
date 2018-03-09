/*
We can prove that the stack has at most n
elements and the queue has at most 2(n−1) elements. Therefore, DFS is much more
economical:  it uses memory proportional to the tree depth.  BFS uses memory
proportional to the size of the tree.

 Drawing trees(jump)

Parsing
A parser is part of a compiler. A compiler is a program that translates a sequence
of characters, which represents a program, into a sequence of low-level instructions
that can be executed on a machine. 
(jump)
The parser program
The main parser call is the function {Prog  S1  Sn}, where S1 is an input list of
tokens and Sn is the rest of the list after parsing.  This call returns the parsed
output.

Time and space eﬃciency(jump)
 Amortized complexity(jump)

  Higher-order programming
  There are four basic operations that underlie all the techniques of higher-order
programming:
•  Procedural abstraction: the ability to convert any statement into a pro-
cedure value.
•  Genericity: the ability to pass procedure values as arguments to a proce-
dure call.
•  Instantiation:  the ability to return procedure values as results from a
procedure call.
•  Embedding: the ability to put procedure values in data structures.


Procedural abstraction
We have already introduced procedural abstraction.   Let us brieﬂy recall the
basic idea. Any statement hstmti can be “packaged” into a procedure by writing
it as proc  {$} hstmti end.  This does not execute the statement, but instead
creates a procedure value (a closure).  Because the procedure value contains a contextual environment, executing it gives exactly the same result as executing
hstmti. The decision whether or not to execute the statement is not made where
the statement is deﬁned, but somewhere else in the program. Figure 3.20 shows
the two possibilities: either executing hstmti immediately or with a delay.

The restrictions of C and Pascal are a consequence of the way these languages
do memory management. In both languages, the implementation puts part of the
store on the semantic stack. This part of the store is usually called local variables.
Allocation is done using a stack discipline. E.g., some local variables are allocated at each procedure entry and deallocated at the corresponding exit. 
This is a
form of automatic memory management that is much simpler to implement than
garbage collection.  Unfortunately, it is easy to create dangling references.  It is
extremely diﬃcult to debug  a large program that occasionally behaves incorrectly
because of a dangling reference.


Genericity

fun  {SumList  L}
    case  L
    of  nil  then  0
    []  X|L1  then  X+{SumList  L1}
    end
end

fun  {FoldR  L  F  U}
    case  L
    of  nil  then  U
    []  X|L1  then  {F  X  {FoldR  L1  F  U}}
    end
end

Mergesort made generic(jump)

Instantiation
returns a sorting func-
tion. Functions like MakeSort are sometimes called “factories” or “generators”.
MakeSort takes a boolean comparison function F and returns a sorting routine
that uses F as comparison function.  Let us see how to build MakeSort using a
generic sorting routine Sort. Assume that Sort takes two inputs, a list L and a
boolean function F, and returns a sorted list.

fun  {MakeSort  F}
    fun  {$  L}
        {Sort  L  F}
    end
end

Embedding
This has many uses:
•  Explicit  lazy  evaluation,  also called delayed  evaluation.   The idea
is not to build a complete data structure in one go,  but to build it on
demand.  Build only a small part of the data structure with procedures at
the extremities that can be called to build more. For example, the consumer
of a data structure is given a pair:  part of the data structure and a new
function to calculate another pair.  This means the consumer can control
explicitly how much of the data structure is evaluated.
•  Modules. A module is a record that groups together a set of related oper-
ations.
•  Software component. A software component is a generic procedure that
takes a set of modules as input arguments and returns a new module.  It
can be seen as specifying a module in terms of the modules it needs (see
Section 6.7).

 Loop abstractions

The procedure {ForAll  L  P} calls {P  X} for all elements X of the list L.
We can relate FoldL
and FoldR to the accumulator loops we saw before. 

U是输入和输出
fun  {FoldL  L  F  U}
    case  L
    of  nil  then  U
    []  X|L2  then
        {FoldL  L2  F  {F  U  X}}
    end
end

fun  {FoldR  L  F  U}
    fun  {Loop  L  U}
        case  L
        of  nil  then  U
        []  X|L2  then
            {Loop  L2  {F  X  U}}
    end
end
in
    {Loop  {Reverse  L}  U}
end
There is a fundamental diﬀerence between a declarative loop and an imperative
loop, i.e., a loop in an imperative language such as C or Java. In the latter, the
loop counter is an assignable variable which is assigned a diﬀerent value on each
iteration.  The declarative loop is quite diﬀerent:  on each iteration it declares a
new variable. All these variables are referred to by the same identiﬁer.  There is
no destructive assignment at all.  This diﬀerence can have major consequences.
For example, the iterations of a declarative loop are completely independent of
each other.  Therefore, it is possible to run them concurrently without changing
the loop’s ﬁnal result. For example:
for  I  in  A..B  do  thread  hstmti  end  end
runs all iterations concurrently but each of them still accesses the right value of I.
Putting hstmti inside the statement thread  ...  end runs it as an independent
activity.  This is an example of declarative concurrency, which is the subject of
Chapter 4. Doing this in an imperative loop would raise havoc since each iteration
would no longer be sure it accesses the right value of I. The increments of the
loop counter would no longer be synchronized with the iterations.

Patterns
The for loop can be extended to contain patterns that implicitly declare vari-
ables.  For example, if the elements of L are triplets of the form obj(name:N
price:P  coordinates:C), then we can loop over them as follows:
for  obj(name:N  price:P  coordinates:C)  in  L  do
    if  P<1000  then  {Show  N}  end
end
This declares and binds the new variables N, P, and C for each iteration.  Their
scope ranges over the loop body.

 Data-driven techniques
fun  {Map  Xs  F}
    case  Xs
    of  nil  then  nil
    []  X|Xr  then  {F  X}|{Map  Xr  F}
    end
end


fun  {Filter  Xs  F}
    case  Xs
    of  nil  then  nil
    []  X|Xr  andthen  {F  X}  then  X|{Filter  Xr  F}
    []  X|Xr  then  {Filter  Xr  F}
    end
end

proc  {VisitNodes  Tree  P}
    tree(sons:Sons  ...)=Tree
in
    {P  Tree}
    for  T  in  Sons  do  {VisitNodes  T  P}  end
end

proc  {VisitLinks  Tree  P}
    tree(sons:Sons  ...)=Tree
in
    for  T  in  Sons  do  {P  Tree  T}  {VisitLinks  T  P}  end
end

Explicit lazy evaluation
In lazy execution, a data structure (such as a list) is constructed incrementally.
The consumer of the list structure asks for new list elements when they are needed.
This is an example of demand-driven execution. It is very diﬀerent from the usual,
supply-driven evaluation, where the list is completely calculated independent of
whether the elements are needed or not.

To implement lazy execution, the consumer should have a mechanism to ask
for new elements. We call such a mechanism a trigger. There are two natural ways
to express triggers in the declarative model: as a dataﬂow variable or with higher-
order programming.  Section 4.3.3 explains how with a dataﬂow variable.  Here
we explain how with higher-order programming.  The consumer has a function
that it calls when it needs a new list element.  The function call returns a pair:
the list element and a new function. The new function is the new trigger: calling
it returns the next data item and another new function. And so forth.


Currying(jump)

 Abstract data types
 We say a type is abstract if it is completely deﬁned by its set
of operations, regardless of the implementation.   This is abbreviated as ADT.

fun  {NewStack}  nil  end
fun  {Push  S  E}  E|S  end
fun  {Pop  S  E}  case  S  of  X|S1  then  E=X  S1  end  end
fun  {IsEmpty  S}  S==nil  end

Here is another implementation that satisﬁes the laws:
fun  {NewStack}  stackEmpty  end
fun  {Push  S  E}  stack(E  S)  end
fun  {Pop  S  E}  case  S  of  stack(X  S1)  then  E=X  S1  end  end
fun  {IsEmpty  S}  S==stackEmpty  end

A declarative dictionary
Tree-based implementation
A more eﬃcient implementation of dictionaries is possible by using an ordered
binary tree,  as deﬁned in Section 3.4.6.   Put  is simply Insert and CondGet
is very similar to Lookup. 

fun  {NewDictionary}  leaf  end
fun  {Put  Ds  Key  Value}
    %  ...  similar  to  Insert
end
fun  {CondGet  Ds  Key  Default}
    %  ...  similar  to  Lookup
end
fun  {Domain  Ds}
    proc  {DomainD  Ds  ?S1  Sn}
        case  Ds
        of  leaf  then
            S1=Sn
        []  tree(K  _  L  R)  then  S2  S3  in
            {DomainD  L  S1  S2}
            S2=K|S3
            {DomainD  R  S3  Sn}
        end
    end  D
in
    {DomainD  Ds  D  nil}  D
end

We can do even better than the tree-based implementation by leaving the declara-
tive model behind and using explicit state (see Section 6.5.1). This gives a stateful
dictionary, which is a slightly diﬀerent type than the declarative dictionary. But
it gives the same functionality.  Using state is an advantage because it reduces
the execution time of Put and CondGet operations to amortized constant time.


A word frequency application
function WordFreq, which is given a list of characters Cs and returns a list of
pairs W#N, where W is a word (a maximal sequence of letters and digits) and N is
the number of times the word occurs in Cs. 
 {WordChar  C} returns true if C is a letter or digit.
{WordToAtom  PW} converts a reversed list of word characters into an atom
containing those characters. The function StringToAtom is used to create
the atom.
括起来的直接是返回值了
&是取ascii码?
a-z, A-Z, 0-9

fun  {WordChar  C}
    (&a=<C  andthen  C=<&z)  orelse
    (&A=<C  andthen  C=<&Z)  orelse  (&0=<C  andthen  C=<&9)
end

StringToAtom是内置方法?啥是Atom?

fun  {WordToAtom  PW}
    {StringToAtom  {Reverse  PW}}
end

用Dict D来统计W

fun  {IncWord  D  W}
    {Put  D  W  {CondGet  D  W  0}+1}
end

将string Cs里面的word提取出来组成一个list PW

fun  {CharsToWords  PW  Cs}
    % 终极终止条件
    case  Cs
    of  nil  andthen  PW==nil  then
        nil
    % 终极终止条件
    []  nil  then
        [{WordToAtom  PW}]
    % 收集一个word的char
    []  C|Cr  andthen  {WordChar  C}  then
        {CharsToWords  {Char.toLower  C}|PW  Cr}
    % 不是字母或者数字则跳回
    []  C|Cr  andthen  PW==nil  then
        {CharsToWords  nil  Cr}
    % 收集到一个word, PW重新开始
    []  C|Cr  then
        {WordToAtom  PW}|{CharsToWords  nil  Cr}
    end
end

list Ws迭代计算其在D中的计数

fun  {CountWords  D  Ws}
    case  Ws
    of  W|Wr  then  {CountWords  {IncWord  D  W}  Wr}
    []  nil  then  D
    end
end

fun  {WordFreq  Cs}
    {CountWords  {NewDictionary}  {CharsToWords  nil  Cs}}
end


 Secure abstract data types

In both the stack and dictionary data types, the internal representation of values
is visible to users of the type. If the users are disciplined programmers then this
might not be a problem. But this is not always the case. A user can be tempted
to look at a representation or even to construct new values of the representation.
For example, a user of the stack type can use Length to see how many ele-
ments are on the stack, if the stack is implemented as a list. The temptation to
do this can be very strong if there is no other way to ﬁnd out what the size of the
stack is.  Another temptation is to ﬁddle with the stack contents.  Since any list
is also a legal stack value, the user can build new stack values, e.g., by removing
or adding elements.
In short, any user can add new stack operations anywhere in the program.
This means that the stack’s implementation is potentially spread out over the
whole program instead of being limited to a small part. This is a disastrous state
of aﬀairs, for two reasons:
•  The program is much harder to maintain.  For example, say we want to
improve the eﬃciency of a dictionary by replacing the list-based implemen-
tation by a tree-based implementation. We would have to scour the whole
program to ﬁnd out which parts depend on the list-based implementation.
There is also a problem of error conﬁnement:  if the program has bugs in
one part then this can spill over into the abstract data types, making them
buggy as well, which then contaminates other parts of the program.
•  The program is susceptible to malicious interference. This is a more subtle
problem that has to do with security. It does not occur with programs writ-
ten by people who trust each other.  It occurs rather with open programs.
An open program is one that can interact with other programs that are only
known at run-time.  What if the other program is malicious and wants to
disrupt the execution of the open program? Because of the evolution of the
Internet, the proportion of open programs is increasing.

 The value to be protected is put inside a protection boundary.
There are two ways to use this boundary:
•  Stationary value.  The value never leaves the boundary.  A well-deﬁned set
of operations can enter the boundary to calculate with the value. The result
of the calculation stays inside the boundary.
•  Mobile value.  The value can leave and reenter the boundary.  When it is
outside, operations can be done on it. Operations with proper authorization
can take the value out of the boundary and calculate with it. The result is
put back inside the boundary.

In the next section we build a secure ADT using the second solution.  This
way is the easiest to understand for the declarative model. The authorization we
need to enter the protection boundary is a kind of “key”.  We add it as a new
concept to the declarative model, called name. Section 3.7.7 then explains that a
key is an example of a very general security idea, called a capability. In Chapter 6,
Section 6.4 completes the story on secure ADTs by showing how to implement
the ﬁrst solution and by explaining the eﬀect of explicit state on security.

 The declarative model with secure types
 We implement this with a new basic type called a name. A name is a constant
like an atom except that it has a much more restricted set of operations.   In
particular, names do not have a textual representation:  they cannot be printed
or typed in at the keyboard.   Unlike  for atoms,  it is not possible  to convert
between names and strings. The only way to know a name is by being passed a
reference to it within a program. The name type comes with just two operations:
{NewName}    Return a fresh name
N1==N2          Compare names N1 and N2
A fresh name is one that is guaranteed to be diﬀerent from all other names in the
system. Alert readers will notice that NewName is not declarative because calling
it twice returns diﬀerent results. In fact, the creation of fresh names is a stateful
operation.  The guarantee of uniqueness means that NewName has some internal
memory.  However, if we use NewName just for making declarative ADTs secure
then this is not a problem. The resulting secure ADT is still declarative.

Key={NewName}
SS=fun  {$  K}  if  K==Key  then  S  end  end
This ﬁrst creates a new name in Key. Then it makes a function that can return
S, but only if the correct argument is given. We say that this “wraps” the value
S inside SS. If one knows Key, then accessing S from SS is easy:
S={SS  Key}

proc  {NewWrapper  ?Wrap  ?Unwrap}
    Key={NewName}
in
    fun  {Wrap  X}
        fun  {$  K}  if  K==Key  then  X  end  end
    end
    fun  {Unwrap  W}
        {W  Key}
    end
end


*/