% Stack traces for GHC
% Proposal by Arash Rouhani
%

The goal of this project is to develop zero-overhead stack traces for
the GHC compiler.

## Haskell and GHC

*Haskell* is a lazy, functional, programming language. The by far most
used compiler for the language is *GHC*. Both Haskell and GHC appeared
around 1990 and both are active as of today.

## Stack traces

When a computer program crashes, the runtime of the programming language
often gives some information on how the program crashed. Typically, a
*stack trace* is printed. A stack trace is the listing of the functions
that have called each other and have not exited yet, so they have all
been part of the crash. The first function in the stack trace is always
the program entry point, the last function is where the crash actually
occurred.

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
Therefore we call these zero-overhead stack traces.

## Required background knowledge

Here is a list of topics I've taken courses in and believe will help:

  * Functional Programming using Haskell
  * Courses in Compilers, particularly playing around with big real
    world compilers like LLVM.
  
The work will be at a comparably low level in the compiler pipeline.
Whilst Haskell is a functional language, mostly general compiler
knowledge is required.
