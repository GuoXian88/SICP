;self

;answer


These three viewpoints could be laid out on the scale from "imperative" to "declarative". Ben's idea seems to make the most sense, at least for a programmer used to the imperative style. However, it could cause hard to detect bugs, and Scheme is not supposed to be an imperative language anyway. Eva's desired solution seems to be difficult or maybe even impossible to implement, even if it would be kind of nice from a declarative point of view. Alyssa's way of looking at things avoids the problem by simply showing an error and forcing the programmer to write a "better" procedure. This seems to be a good way out.

I don't know how to implement a general system that would make Eva's idea work. For instance, while we could reorder `define`s in such a way that `a` comes before `b` (on the grounds that `b` uses `a` in its definition), this would not work if we had to work with a circular dependency (i.e. `b` depends on `a`, `a` depends on `b`).

One way to solve this issue would be to treat every binding as a function, i.e. `b` would be a function of no arguments that returns some value, and the same thing would apply to `a`. Then, evaluation of those values would happen during the call, and the most recent definition of `a` would be used even though no reordering has been done. However, this would fundamentally change how Scheme works.

