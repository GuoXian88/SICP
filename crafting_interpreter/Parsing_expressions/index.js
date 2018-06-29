/**
 * 
 * 
 * 
 * 随机选一个breakfast， with这种引号的是token
breakfast → protein "with" bread ;
breakfast → protein ;
breakfast → bread ;
可以递归所以可以compose
protein   → protein "and" protein ;
protein   → "bacon" ;
protein   → "sausage" ;
protein   → cooked "eggs" ;

cooked    → "scrambled" ;
cooked    → "poached" ;
cooked    → "fried" ;

bread     → "toast" ;
bread     → "biscuits" ;
bread     → "English muffin" ;


进化版
breakfast → protein ( "and" protein )* ( "with" bread )?
          | bread ;

protein   → "bacon"
          | "sausage"
          | ( "scrambled" | "poached" | "fried" ) "eggs" ;

bread     → "toast" | "biscuits" | "English muffin" ;

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
