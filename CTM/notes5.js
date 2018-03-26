/*
Cooperative and competitive concurrency
 Cooperative concurrency is for entities that are working together on some
global goal. 

 competitive concurrency is for entities that have a local
goal, i.e., they are working just for themselves. They are interested only in their
own performance, not in the global performance.   Competitive concurrency is
usually managed by the operating system in terms of a concept called a process.

Thread operations
 Streams
 using streams to communicate between threads.
 A stream is a
potentially unbounded list of messages, i.e., it is a list whose tail is an unbound
dataﬂow variable.  Sending a message is done by extending the stream by one
element:  bind the tail to a list pair containing the message and a new unbound
tail. Receiving a message is reading a stream element. A thread communicating
through streams is a kind of “active object” that we will call a stream object. No
locking or mutual exclusion is necessary since each variable is bound by only one
thread.
deterministic
stream programming, in which each stream object always knows for each input
where the next message will come from.  This case is interesting because it is
declarative. Yet it is already quite useful. 

Basic producer/consumer
declare  Xs  Xs2  in
Xs=0|1|2|3|4|Xs2

declare  Xs3  in
Xs2=5|6|7|Xs3


生产者消费者：

fun  {Generate  N  Limit}
    if  N<Limit  then
        N|{Generate  N+1  Limit}
    else  nil  end
end

迭代的写法

fun  {Sum  Xs  A}
    case  Xs
    of  X|Xr  then  {Sum  Xr  A+X}
    []  nil  then  A
    end
end

local  Xs  S  in
    thread  Xs={Generate  0  150000}  end    %  Producer  thread
    thread  S={Sum  Xs  0}  end     %  Consumer  thread
    {Browse  S}
end

Using a higher-order iterator
local  Xs  S  in
    thread  Xs={Generate  0  150000}  end
    thread  S={FoldL  Xs  fun{$  X  Y}  X+Y  end  0}  end
    {Browse  S}
end

 Transducers and pipelines
 We can put a third stream object in between the producer and consumer.  This
stream  object reads the  producer’s stream  and creates  another stream  which
is read by the consumer.   We call it a transducer. 
 In general,  a sequence  of
stream objects each of which feeds the next is called a pipeline. The producer is
sometimes called the source and the consumer is sometimes called the sink. Let
us look at some pipelines with diﬀerent kinds of transducers.

Filtering a stream
这个是不是互为质数?不是就是产生2开始的质数流

fun  {Sieve  Xs}
    case  Xs
    of  nil  then  nil
    []  X|Xr  then  Ys  in
        thread  Ys={Filter  Xr  fun  {$  Y}  Y  mod  X  \=  0  end}  end
        X|{Sieve  Ys}
    end
end


local  Xs  Ys  in
    thread  Xs={Generate  2  100000}  end
    thread  Ys={Sieve  Xs}  end
    {Browse  Ys}
end

Flow control with demand-driven concurrency
The simplest ﬂow control is called demand-driven concurrency, or lazy execution.


proc  {DGenerate  N  Xs}
    case  Xs  of  X|Xr  then
        X=N
        {DGenerate  N+1  Xr}
    end
end

fun  {DSum  ?Xs  A  Limit}
    if  Limit>0  then
        X|Xr=Xs
    in
        {DSum  Xr  A+X  Limit-1}
    else  A  end
end

local  Xs  S  in
    thread  {DGenerate  0  Xs}  end          %  Producer  thread
    thread  S={DSum  Xs  0  150000}  end  %  Consumer  thread
    {Browse  S}
end

Flow control with a bounded buﬀer
 But
lazy execution  also has  a serious  problem.   It leads  to a strong  reduction  in
throughput. By throughput we mean the number of messages that can be sent per
unit of time.
 If the consumer
requests a message, then the producer has to calculate it, and meanwhile the
consumer waits. If the producer were allowed to get ahead of the consumer, then
the consumer would not have to wait.

 A
bounded buﬀer is a transducer that stores elements up to a maximum number, say
n. The producer is allowed to get ahead of the consumer, but only until the buﬀer
is full. This limits the extra resource usage to n elements. The consumer can take
elements from the buﬀer immediately without waiting.  This keeps throughput
high.   When  the buﬀer has less  than n elements,  the  producer is allowed  to
produce more elements, until the buﬀer is full.

proc  {Buffer  N  ?Xs  Ys}
    % Startup从生产者Xs里填充N个元素到buffer中，生产者连续产生N个元素
    fun  {Startup  N  ?Xs}
        if  N==0  then  Xs
        else  Xr  in  Xs=_|Xr  {Startup  N-1  Xr}  end
    end
    % 消费者要一个元素就从buffer中取(已经计算好了，无需等待),然后buffer再向生产者请求一个元素
    proc  {AskLoop  Ys  ?Xs  ?End}
        case  Ys  of  Y|Yr  then  Xr  End2  in
            Xs=Y|Xr        %  Get  element  from  buffer
            End=_|End2  %  Replenish  the  buffer
            {AskLoop  Yr  Xr  End2}
        end
    end
    End={Startup  N  Xs}
in
    {AskLoop  Ys  Xs  End}
end

Flow control with thread priorities

 Stream objects
We call a stream object an object because it has an internal state that is
accessed in a controlled way (by messages on streams). 
StreamObject is a kind of “template” for creating a stream object. Its behavior
is deﬁned by NextState, which takes an input message M and a state X1, and
calculates an output message N and a new state X2. Executing StreamObject in a new thread creates a new stream object with input stream S0, output stream
T0, and initial state X0. 
proc  {StreamObject  S1  X1  ?T1}
    case  S1
    of  M|S2  then  N  X2  T2  in
        {NextState  M  X1  N  X2}
        T1=N|T2
        {StreamObject  S2  X2  T2}
    else  skip  end
end

declare  S0  X0  T0  in
thread
    {StreamObject  S0  X0  T0}
end


Using the declarative concurrent model directly
Order-determining concurrency
use dataﬂow concurrency to ﬁnd the order automatically.

Coroutines
A coroutine is called explicitly like a procedure, but each coroutine has its has its own locus of control,like a thread.
Coroutines have two operations, Spawn and Resume.
The {Resume  CId} operation
transfers control from the current coroutine to the coroutine with identity CId.

Concurrent composition


 */