import Data.List
import Data.Char
import Data.Bits (xor, shiftL, (.&.))
import Data.Binary
import Numeric (showIntAtBase)

-- bl takes a 2-tuple string of binary numbers and adds them together
bl :: String -> String -> IO ()
bl x y = b(d(x), d(y))
    where d = foldl' (\c x -> c * 2 + digitToInt x) 0 
          b (x, y)
            | y == 0    = putStrLn $ showIntAtBase 2 intToDigit x ""
            | otherwise = b(xor x y, shiftL (x.&.y) 1) 
