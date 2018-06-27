package com.craftinginterpreters.lox;

abstract class Expr {
    static class Binary extends Expr {
        // 二元运算，左表达式 operator 右表达式
        Binary(Expr left, Token operator, Expr right) {
            this.left = left;
            this.operator = operator;
            this.right = right;
        }

        final Expr left;
        final Token operator;
        final Expr right;
    }

    // Other expressions...
}

// Metaprogramming the trees

/*
 * We have a family of classes and we need to associate a chunk of behavior with
 * each one. The natural solution in an object-oriented language like Java is to
 * put that behavior into methods on the classes themselves. We could add an
 * abstract interpret() method on Expr which each subclass then implements to
 * interpret itself.
 * 
 * This works alright for tiny projects, but it scales poorly. Like I noted
 * before, these tree classes span a few domains. At the very least, both the
 * parser and interpreter will mess with them. As you’ll see later, we need to
 * do name resolution on them. If our language was statically typed, we’d have a
 * type checking pass. If we added instance methods to the expression classes
 * for every one of those operations, that would smush a bunch of different
 * domains together. That violates separation of concerns and leads to hard to
 * maintain code.
 * 
 * The Visitor pattern
 * 
 * 
 */