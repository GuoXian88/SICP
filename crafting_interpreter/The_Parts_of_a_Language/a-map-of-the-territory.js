/**
 One way to visualize that precedence is using a tree. Leaf nodes are numbers, and interior nodes are operators with branches for each of their operands.


 In order to evaluate an arithmetic node, you need to know the numeric values of its subtrees, so you have to evaluate those first. That means working your way from the leaves up to the root—a post-order traversal

But regular languages aren’t powerful enough to handle expressions which can nest arbitrarily deeply.
context-free grammar (CFG).

Now each “letter” in the alphabet is an entire token and a “string” is a sequence of tokens—an entire expression.


A terminal is a letter from the grammar’s alphabet. You can think of it like a literal value. In the syntactic grammar we’re defining, the terminals are individual lexemes—tokens coming from the scanner like if or 1234.

These are called “terminals”, in the sense of an “end point” because they don’t lead to any further “moves” in the game. You simply produce that one symbol.

A nonterminal is a named reference to another rule in the grammar. It means “play that rule and insert whatever it produces here”. In this way, the grammar composes.


protein → protein "and" protein ;
Note that the production refers to its own rule. This is the key difference between context-free and regular languages. The former are allowed to recurse. It is exactly this that lets them nest and compose.
 The fact that a rule can refer to itself—directly or indirectly—kicks it up even more, letting us pack an infinite number of strings into a finite grammar.


 正则来拉
 protein → protein ( "and" protein )* ;
 breakfast → protein ( "with" bread )? ;

 
Syntax trees are not so homogenous. Unary expressions have a single operand, binary expressions have two, and literals have none. We could mush that all together into a single Expression class with an arbitrary list of children. Some compilers do.

 */
