/**
 * 
 * 要是真正的用心，而不是以为自己懂了的那种，才能深刻理解，提高效率
 * think what others are saying. Live every second of your life
 Fairy tales are more than true: not because they tell us that dragons exist, but because they tell us that dragons can be beaten.

 I learn best by doing
 It’s hard for me to wade through paragraphs full of abstract 
 concepts and really absorb them. But if I’ve coded something, ran it, and debugged it, then I get it.


 While I intend to show you that a programming language isn’t as daunting as you might believe, it is still a 
 challenge. Rise to it, and you’ll come away a stronger programmer, and smarter about how you use data 
 structures and algorithms in your day job.

My hope is that if you’ve felt intimidated by languages, and this book helps you overcome that fear, maybe I’ll 
leave you just a tiny bit braver than you were before.

 Our C interpreter will contain a compiler that translates the code to an efficient bytecode representation 
 (don’t worry, I’ll get into what that means soon) which it then executes. This is the same technique used by 
 implementations of Lua, Python, Ruby, PHP and many other successful languages.
 

 CHALLENGES
There are at least six domain-specific languages used in the little 
system I cobbled together to write and publish this book. What are 
they?
这个找不到
sass markdown HTML Make CSS Jinja


Get a “Hello, world!” program written and running in Java. Set up 
whatever Makefiles or IDE projects you need to get it working. If you 
have a debugger, get comfortable with it and step through your 
program as it runs.

done in IntelliJ IDEA

Do the same thing for C. To get some practice with pointers, define a 
doubly-linked list of heap-allocated strings. Write functions to 
insert, find, and delete items from it. Test them.

TODO
 */


 
//Lox/Scanner.java in scanToken() replace 1 line
default:
    if (isDigit(c)) {
        number();
    } else {
        Lox.error(line, "Unexpected character.");
    }
break;