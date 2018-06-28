/**
 * 
 * 
 expression → literal
           | unary
           | binary
           | grouping ;

literal    → NUMBER | STRING | "false" | "true" | "nil" ;
grouping   → "(" expression ")" ;
unary      → ( "-" | "!" ) expression ;
binary     → expression operator expression ;
operator   → "==" | "!=" | "<" | "<=" | ">" | ">="
           | "+"  | "-"  | "*" | "/" ;

解析可能产生歧义，如优先级问题
In other words, the grammar allows seeing the expression as (6 / 3) - 1 or 6 / (3 - 1)
left-associative
(5 - 3) - 1
right-associative
a = (b = c)
 */
