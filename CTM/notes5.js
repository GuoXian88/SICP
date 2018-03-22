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

 */