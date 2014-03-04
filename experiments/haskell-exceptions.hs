{-# LANGUAGE ExistentialQuantification, DeriveDataTypeable #-}

import Control.Exception
import Data.Typeable

main :: IO()
main = undefined

--------------------------------------------------------------------
-- Make the root exception type for all the exceptions in a compiler

data SomeCompilerException = forall e . Exception e => SomeCompilerException e
    deriving Typeable

instance Show SomeCompilerException where
    show (SomeCompilerException e) = show e

instance Exception SomeCompilerException

compilerExceptionToException :: Exception e => e -> SomeException
compilerExceptionToException = toException . SomeCompilerException

compilerExceptionFromException :: Exception e => SomeException -> Maybe e
compilerExceptionFromException x = do
    SomeCompilerException a <- fromException x
    cast a

---------------------------------------------------------------------
-- Make a subhierarchy for exceptions in the frontend of the compiler

data SomeFrontendException = forall e . Exception e => SomeFrontendException e
    deriving Typeable

instance Show SomeFrontendException where
    show (SomeFrontendException e) = show e

instance Exception SomeFrontendException where
    toException = compilerExceptionToException
    fromException = compilerExceptionFromException

frontendExceptionToException :: Exception e => e -> SomeException
frontendExceptionToException = toException . SomeFrontendException

frontendExceptionFromException :: Exception e => SomeException -> Maybe e
frontendExceptionFromException x = do
    SomeFrontendException a <- fromException x
    cast a

---------------------------------------------------------------------
-- Make an exception type for a particular frontend compiler exception

data MismatchedParentheses = MismatchedParentheses
    deriving (Typeable, Show)

instance Exception MismatchedParentheses where
    toException   = frontendExceptionToException
    fromException = frontendExceptionFromException

unpackToCompilerException :: SomeException -> SomeCompilerException
unpackToCompilerException (SomeException x) = case cast x of
    Just y  -> y
    Nothing -> error "not an SomeCompilerException"

unpackToFrontendException :: SomeCompilerException -> SomeFrontendException
unpackToFrontendException (SomeCompilerException x) = case cast x of
    Just y  -> y
    Nothing -> error "not an SomeFrontendException"

unpackToMismatchedParenthesis :: SomeFrontendException -> MismatchedParentheses
unpackToMismatchedParenthesis (SomeFrontendException x) = case cast x of
    Just y  -> y
    Nothing -> error "not an MismatchedParentheses"

unpackChain :: SomeException -> MismatchedParentheses
unpackChain = unpackToMismatchedParenthesis . unpackToFrontendException . unpackToCompilerException 
