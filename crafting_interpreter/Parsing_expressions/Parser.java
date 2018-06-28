package com.craftinginterpreters.lox;

import java.util.List;

import static com.craftinginterpreters.lox.TokenType.*;

class Parser {
    private final List<Token> tokens;
    private int current = 0;

    Parser(List<Token> tokens) {
        this.tokens = tokens;
    }

    private Expr expression() {
        return equality();
    }

    // equality → comparison ( ( "!=" | "==" ) comparison )* ;
    // 相等判断，存等号左边的expression再存==或者 !=再存右边的expression,然后再循环
    private Expr equality() {
        // Let’s step through it. The left comparison nonterminal in the body is
        // translated to the first call to comparison() and we store that in a local
        // variable.
        Expr expr = comparison();

        // Then, the ( ... )* loop in the rule is mapped to a while loop. We need to
        // know when to exit that loop. We can see that inside the rule, we must first
        // find either a != or == token. So, if we don’t see one of those, we must be
        // done with the sequence of equality operators. We express that check using a
        // handy match() method
        while (match(BANG_EQUAL, EQUAL_EQUAL)) {
            Token operator = previous();
            Expr right = comparison();
            expr = new Expr.Binary(expr, operator, right);
        }

        return expr;
    }

}