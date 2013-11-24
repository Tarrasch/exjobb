{-# LANGUAGE DeriveDataTypeable #-}
module InsideNew where

import Control.Exception
import Data.Typeable

data MyException = MyException
   deriving (Show, Typeable)

instance Exception MyException

insideNew :: IO Int
insideNew = catch dangerousAction handler
  where
    dangerousAction :: IO Int
    dangerousAction = error "We're gonna crash"
    handler :: SomeException -> IO Int
    handler e = -- A catch-all handler
      if 1 == 2
      then do putStrLn "Handled!"
              return 200
      else do putStrLn "Have to propagate :/"
              throw newException -- Throw along a different exception, not e!
    newException = MyException -- Whatever here really
