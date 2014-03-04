{-# NOINLINE addition #-}
addition :: Int -> Int -> Int
addition x y = (x + y)

main = print (addition 2 3)
