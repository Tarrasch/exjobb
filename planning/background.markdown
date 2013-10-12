# Background

## Stack traces

When a computer program crashes, the runtime of the programming language often
gives some context to where in the code the program crashed. Typically, a
*stack trace* is printed. A stack trace is the listing of the functions that
have called each other and have not exited yet, so they have all been part of
the crash. The first function in the stack trace is always the program entry
point, the last function is where the crash actually occurred.

## Haskell

Haskell is a lazy, functional, general-purpose programming language.
(sources...) It first appearead in 1990 (source) and have since released
the major standards Haskell 98 and Haskell 2010 (sources...). A simple
program can look like this.

```
main = print (fibonacci 5)

fibonacci :: Int -> Int
fibonacci 1 = 1
fibonacci 2 = 1
fibonacci x = fibonacci (x - 1) + fibonacci (x - 2)
```
(bildtext: "A simple Haskell program")


Two functions are defined in this program, `main` and `fibonacci`.  The
explicit type signature for the function `fibonacci` means that it takes
an int and returns an int. If a type signature is omitted, like for
`main`, haskell will infer the program's type.

### Error handling in Haskell

In order for stack traces to be relevant for a programming language, programs
must have the notion of crashing. Crashing means sudden stops in execution,
either at a level managed by the operating system or by the language's own
exception handling. Program crashes are costly for long-running process and
hence there are language constructs to eliminate some causes of program
crashes.

In Haskell, there's a notion of a function being *total*. Meaning that a
function will terminate and not return any error. As of the famous halting
problem it's not possible to decide if a function will terminate or not, though
whenever we programmatically excplicitly choose to crash we can avoid it.

Java, which might be a more familar language to the reader, implements this idea
through the `throws` keyword. For example, here are two safe integer division
functions in both languages.

```
int integerDivision (int nominator, int denominator) throws ArithmeticException {
    if (denominator == 0) {
        throws Arithmeticexception("Division by zero");
    }
    else {
        return nominator / denominator;
    }
}
```

And similarly in haskell

```
integerDivision :: Int -> Int -> Maybe[1] Int
integerDivision n 0 = Nothing
integerdivision n d = Just (n `div` d)
```

The two functions are considered to not crash when diving by zero, rather, they
gracefully return a value of either the division or a graceful value
representing division by zero. But as a drawback, both these functions are
cumbersome to use. In java the programmer needs to excplicitly catch the
Exception using the `try-catch` construct. In Haskell, an additional layer of pattern
matching is required over just regular division. Due to this inconvenience,
both languages allow for carrying out integer division immedietly without
forcing the caller to do any error handling.

```
int integerDivisionUnsafe (int n, int d) {
    return n / d;
}
```

and for haskell

```
integerDivision :: Int -> Int -> Int
integerDivision n 0 = error "Division by zero"
integerDivision n d = n `div` d
```

For the first time we now see the `error` function in haskell. It's a special
in-built function that terminates execution and outputs the error message.
While it's not entirely accurate, we could think of `error` being the only way
to cause a crash in haskell. That means that all the typical dangerous
operations like integer division by zero or indexing outside an array would
just be calls to the `error` function. Now, "crashing" is well-defined for
haskell programs, it's just a call to `error` (footnote: It's rather the
evaluation of an expression tree having `error` as it's top element).

## Glasgow Haskell Compiler

The Glasgow Haskell Compiler (GHC) is a Haskell2010 compatible compiler.
(source)
With it you can compile Haskell source code to an executeable binary.
Here's an invocation of the compiler on the program sample above

```
$ ghc --make Fibonacci.hs
...
$ ./a.out
123
(TODO check)
```

Haskell is the by far most used haskell compiler (source). It has always
(?) been in active (?) development since its first release in 199x
(source).  Since then, many notable extensions have been added. GHC as
of today support many features in addition to the Haskell2010 standard,
like parallelism, many optimizations, an llvm backend, profiling support
and more. This work is adding stack traces to that list.

# Related work

For GHC, the defualt settings do not print stack traces on errors. While there
are many successful stack trace implementations in haskell, they are not basing
their on the actual execution stack. This performance penalty leaves them out
of being a default option of ghc. On the other hand the execution stack is
harder to interpret, here follows a listing of previous work about stack traces
for haskell who all essentially work with maintaining a seperate structure
representing the stack that's passed along during execution.

## Haskell data visualization

## Other work on Stack Traces for Haskell

### Overhead-full stack traces

Stack traces can be achieved by doing methodological source level
tranformations. For instance program (below) have been transformed into
program (below2) using a generally applicable source level
transformation.
> Lastly program (below3) is yet another tranformation of
> (below), only using a Stack Trace  *Monads*. This particular monad
> represents a computational context for stack traces.

```
main = print (f 100 200)

f :: Int -> Int -> Int
f x y = g (5*x + y)

g :: Int -> Int
g 7 = error "I crash becuase you passed me seven"
g x = 100 * x

```

```
type CrashInfo = String

f :: CrashInfo -> Int -> Int -> Int
f crashInfo x y = g (newInfo) (5*x + y)
    where
      newInfo = "f (case 1)\n" ++ crashInfo

g :: CrashInfo -> Int -> Int
g crashInfo 7 = error ("I crash becuase you passed me seven" ++ newInfo)
    where
      newInfo = "g (case 1)\n" ++ crashInfo
g crashInfo x = 100 * x
    where
      newInfo = "g (case 2)\n" ++ crashInfo
```

Where `str1 ++ str2` is standard string concatenation. While we won't formalize
nor prove the correctness of this transformation, it's essentially doing:

  * Transform all top level functions to take one additional string argument
  * Transform all equations to have an decleration of their new stack, and pass
    it as the first argument to all calls of top level functions within that
    equation.
  * Transform all calls to `error` a

This transformation is similar to 'http://ghc.haskell.org/trac/ghc/wiki/ExplicitCallStack#Transformationoption1' (9th oct 2013)
