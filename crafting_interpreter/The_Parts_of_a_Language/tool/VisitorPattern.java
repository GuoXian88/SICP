abstract class Pastry {
    abstract void accept(PastryVisitor visitor);
}

class Beignet extends Pastry {
    @Override
    void accept(PastryVisitor visitor) {
        visitor.visitBeignet(this);
    }
}

class Cruller extends Pastry {
    @Override
    void accept(PastryVisitor visitor) {
        visitor.visitCruller(this);
    }
}

/*
 * We want to be able to define new operations for them—cooking them, eating
 * them, decorating them, etc.—without having to add a new method to each class
 * every time. Here’s how we do it. First, we define a separate interface:
 */

interface PastryVisitor {
    void visitBeignet(Beignet beignet);

    void visitCruller(Cruller cruller);
}

/**
 * To define a new operation that can be performed on pastries, we create a new
 * class that implements that interface. It has a concrete method for each type
 * of pastry. That keeps the code for the operation on both types all nestled
 * snuggly together in one class.
 * 
 * Given some pastry, how do we route it to the correct method on the visitor
 * based on its type? Polymorphism to the rescue! We add this method to Pastry:
 * 
 * That’s the heart of the trick right there. It lets us use polymorphic
 * dispatch on the pastry classes to select the appropriate method on the
 * visitor class.
 */