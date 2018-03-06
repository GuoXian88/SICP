/*
This section gives the
basic techniques of programming with lists:
•  Thinking recursively:  the basic approach is to solve a problem in terms of
smaller versions of the problem.
•  Converting recursive to iterative computations: naive list programs are often
wasteful because their stack size grows with the input size.  We show how
to use state transformations to make them practical.
•  Correctness of iterative computations: a simple and powerful way to reason
about iterative computations is by using state invariants.
•  Constructing programs by following the type: a function that calculates with
a given type almost always has a recursive structure that closely mirrors
the type deﬁnition

 Later
sections show how to make the writing of iterative functions more systematic
by  introducing accumulators  and diﬀerence  lists.   This  lets us  write iterative
functions from the start.   We ﬁnd that these techniques “scale up”, i.e., they
work well even for large declarative programs.

A base case.
A recursive case

fun  {Length  Ls}
    case  Ls
    of  nil  then  0
    []  _|Lr  then  1+{Length  Lr}
    end
end
{Browse  {Length  [a  b  c]}}

type signature: <fun  {$ <List>}: <Int>>

fun  {Append  Ls  Ms}
    case  Ls
    of  nil  then  Ms
    []  X|Lr  then  X|{Append  Lr  Ms}
    end
end

fun  {Nth  Xs  N}
    if  N==1  then  Xs.1
    elseif  N>1  then  {Nth  Xs.2  N-1}
    end
end

The list has only four elements. Trying to ask for the ﬁfth element means trying
to do Xs.1 or Xs.2 when Xs=nil. This will raise an exception. An exception is
also raised if N is not a positive integer, e.g., when N=0. This is because there is
no else clause in the if statement.

Start with a recursive
deﬁnition of list reversal:
•  Reverse of nil is nil.
•  Reverse of X|Xs is Z, where
reverse of Xs is Ys, and
append Ys and [X] to get Z.

fun  {Reverse  Xs}
    case  Xs
    of  nil  then  nil
    []  X|Xr  then
        {Append  {Reverse  Xr}  [X]}
    end
end

There will be n recursive calls followed by
n calls to Append.  Each Append call will have a list of length n/2 on average.
The total execution time is therefore proportional to n · n/2, namely n2.  This
is rather slow.   We would expect that reversing a list, which is not exactly a
complex calculation, would take time proportional to the input length and not
to its square.
This program has a second defect:  the stack size grows with the input list
length,  i.e.,  it  deﬁnes  a recursive  computation  that  is  not iterative.   Naively
following the recursive deﬁnition of reverse has given us a rather ineﬃcient result!

How can we calculate the list length with an iterative computation, which has
bounded stack size? To do this, we have to formulate the problem as a sequence
of state transformations.  That is, we start with a state S0  and we transform it
successively, giving S1, S2, ..., until we reach the ﬁnal state Sﬁnal, which contains
the answer.  To calculate the list length, we can take the length i of the part of
the list already seen as the state. Actually, this is only part of the state. The rest
of the state is the part Ys of the list not yet seen. The complete state Si  is then
the pair (i, Ys).  The general intermediate case is as follows for state Si  (where
the full list Xs is [e1  e2   · · · en])

fun  {IterLength  I  Ys}
    case  Ys
    of  nil  then  I
    []  _|Yr  then  {IterLength  I+1  Yr}
    end
end

 Note the diﬀerence with the previous
deﬁnition. Here the addition I+1 is done before the recursive call to IterLength,
which is the last call. We have deﬁned an iterative computation.

local
    fun  {IterLength  I  Ys}
        case  Ys
        of  nil  then  I
        []  _|Yr  then  {IterLength  I+1  Yr}
        end
    end
in
    fun  {Length  Xs}
        {IterLength  0  Xs}
    end
end

This deﬁnes an iterative computation to calculate the list length.  Note that we
deﬁne IterLength outside of Length.  This avoids creating a new procedure
value each time Length is called. There is no advantage to deﬁning IterLength
inside Length, since it does not use Length’s argument Xs.


We can use the same technique on Reverse as we used for Length.  In the
case of Reverse, the state uses the reverse of the part of the list already seen
instead of its length.  Updating the state is easy: we just put a new list element
in front. The initial state is nil. This gives the following version of Reverse:

local
    fun  {IterReverse  Rs  Ys}
        case  Ys
        of  nil  then  Rs
        []  Y|Yr  then  {IterReverse  Y|Rs  Yr}
        end
    end
in
    fun  {Reverse  Xs}
        {IterReverse  nil  Xs}
    end
end

This version of Reverse is both a linear-time and an iterative computation.

fun  {LengthL  Xs}
    case  Xs
    of  nil  then  0
    []  X|Xr  andthen  {IsList  X}  then
        {LengthL  X}+{LengthL  Xr}
    []  X|Xr  then
        1+{LengthL  Xr}
    end
end

There is an important lesson to be learned here.  It is important to deﬁne a
recursive type before writing the recursive function that uses it.  Otherwise it is
easy to be misled by an apparently simple function that is incorrect. This is true
even in functional languages that do type inference, such as Standard ML and
Haskell. Type inference can verify that a recursive type is used correctly, but the
design of a recursive type remains the programmer’s responsibility.

Sorting with mergesort

fun  {Merge  Xs  Ys}
    case  Xs  #  Ys
    of  nil  #  Ys  then  Ys
    []  Xs  #  nil  then  Xs
    []  (X|Xr)  #  (Y|Yr)  then
        if  X<Y  then  X|{Merge  Xr  Ys}
        else  Y|{Merge  Xs  Yr}
        end
    end
end

proc  {Split  Xs  ?Ys  ?Zs}
    case  Xs
    of  nil  then  Ys=nil  Zs=nil
    []  [X]  then  Ys=[X]  Zs=nil
    []  X1|X2|Xr  then  Yr  Zr  in
        Ys=X1|Yr
        Zs=X2|Zr
        {Split  Xr  Yr  Zr}
    end
end

fun  {MergeSort  Xs}
    case  Xs
    of  nil  then  nil
    []  [X]  then  [X]
    else  Ys  Zs  in
        {Split  Xs  Ys  Zs}
        {Merge  {MergeSort  Ys}  {MergeSort  Zs}}
    end
end


 Accumulators
  By state threading we mean that each proce-
dure’s output is the next procedure’s input.  The technique of threading a state
through nested procedure calls is called accumulator programming.

We no longer program in this style; we ﬁnd that programming with explicit
state is simpler and more eﬃcient (see Chapter 6). It is reasonable to use a few
accumulators in a declarative program; it is actually quite rare that a declarative
program does not need a few. On the other hand, using many is a sign that some
of them would probably be better written with explicit state.

S#L2={MergeSortAcc  L1  N} takes an input list L1 and an integer N. It
returns two results: S, the sorted list of the ﬁrst N elements of L1, and L2,
the remaining elements of L1. The two results are paired together with the
# tupling constructor.

fun  {MergeSort  Xs}
    fun  {MergeSortAcc  L1  N}
        if  N==0  then
            nil  #  L1
        elseif  N==1  then
            [L1.1]  #  L1.2
        elseif  N>1  then
            NL=N  div  2
            NR=N-NL
            Ys  #  L2  =  {MergeSortAcc  L1  NL}
            Zs  #  L3  =  {MergeSortAcc  L2  NR}
        in
            {Merge  Ys  Zs}  #  L3
        end
    end
in
    {MergeSortAcc  Xs  {Length  Xs}}.1
end

The Merge function is unchanged.  Remark that this mergesort does a diﬀerent
split than the previous one.  In this version, the split separates the ﬁrst half of
the input list from the second half.  In the previous version, split separates the
odd-numbered list elements from the even-numbered elements.
This version has the same time complexity as the previous version. It uses less
memory because it does not create the two split lists. They are deﬁned implicitly
by the combination of the accumulating parameter and the number of elements.

Diﬀerence lists
A diﬀerence list is a pair of two lists, each of which might have an unbound tail.
The two lists have a special relationship:  it must be possible to get the second
list from the ﬁrst by removing zero or more elements from the front.
 The diﬀerence list
[a  b  c  d]#[d] might contain the lists [a  b  c  d] and [d], but it represents
neither of these. It represents the list [a  b  c].
Diﬀerence lists are a special case of diﬀerence structures.  A diﬀerence struc-
ture is a pair of two partial values where the second value is embedded in the ﬁrst.
The diﬀerence structure represents a value that is the ﬁrst structure minus the
second structure.
Using diﬀerence structures makes it easy to construct iterative
computations on many recursive datatypes, e.g., lists or trees.  Diﬀerence lists
and diﬀerence structures are special cases of accumulators in which one of the
accumulator arguments can be an unbound variable.

The  advantage of using  diﬀerence  lists  is  that when  the  second  list  is an
unbound variable, another diﬀerence list can be appended to it in constant time.
To append (a|b|c|X)#X and (d|e|f|Y)#Y, just bind X to (d|e|f|Y).  This
creates the diﬀerence list (a|b|c|d|e|f|Y)#Y. We have just appended the lists
[a  b  c] and [d  e  f] with a single binding. 


fun  {AppendD  D1  D2}
    S1#E1=D1
    S2#E2=D2
in
    E1=S2
    S1#E2
end

As a concept, a diﬀerence list lives somewhere between the concept of
value and the concept of state.  It has the good properties of a value (programs
using them are declarative), but it also has some of the power of state because it
can be appended once in constant time.


fun  {Flatten  Xs}
    proc  {FlattenD  Xs  ?Ds}
        case  Xs
        of  nil  then  Y  in  Ds=Y#Y
        []  X|Xr  andthen  {IsList  X}  then  Y1  Y2  Y4  in
            Ds=Y1#Y4
            {FlattenD  X  Y1#Y2}
            {FlattenD  Xr  Y2#Y4}
        []  X|Xr  then  Y1  Y2  in
            Ds=(X|Y1)#Y2
            {FlattenD  Xr  Y1#Y2}
        end
    end  Ys
in
    {FlattenD  Xs  Ys#nil}  Ys
end
