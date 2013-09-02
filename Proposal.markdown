# Stack traces for GHC

The goal of this project is to develop zero-overhead stack traces for
the GHC compiler.

## Stack traces

When a computer program crashes, the runtime of the programming language
often gives some information on how the program crashed. Typically, a
*stack trace* is printed. A stack trace is a list of all the functions
entered that are currently "on the stack".

For GHC, no such information is printed on a program crash. That makes
it difficult for software developers to find the cause of a crash.
Hence, having stack traces for Haskell will be useful for many users.

### Zero-overhead stack traces

The work for this project would be to

  * Make the Haskell compiler include debug information inside the
    executeable binary
  * Change the Haskell runtime system so that whenever the program
    crashes, it should print a stack trace by using the debug
    information inside the binary

So there will be no overhead when running the compiled program.
Therefor we call these zero-overhead stack traces.

## Required background knowledge

Compilers. The work will be at a comparably low level in the compiler
pipeline. Whilst Haskell is a functional language, mostly general
compiler knowledge is required.
