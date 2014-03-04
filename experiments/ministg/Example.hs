-- Code for when showing in thesis what ministg language is

{-# NOINLINE doubleAddition #-}
doubleAddition :: Int -> Int -> Int
doubleAddition x y = tot + tot
  where tot = x + y

{-# NOINLINE globalThunk #-}
globalThunk :: Int
globalThunk = doubleAddition 2 3

main :: IO ()
main = print globalThunk
