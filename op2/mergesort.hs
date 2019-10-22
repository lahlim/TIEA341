module Exercise where
import Data.List hiding (sort)

deal :: [a] -> ([a],[a])
deal list = splitAt (((length list) + 1) `div` 2) list

merge :: Ord a => [a] -> [a] -> [a]
merge xs     []     = xs
merge []     ys     = ys
merge (x:xs) (y:ys) | y < x     = y : merge (x:xs) ys
merge (x:xs) (y:ys) | otherwise = x : merge xs (y:ys)

mergeSort :: Ord a => [a] -> [a]
mergeSort [] = []
mergeSort [a] = [a]
mergeSort a =
  merge (mergeSort firstFew) (mergeSort lastFew)
    where firstFew = take ((length a) `div` 2) a
          lastFew = drop ((length a) `div` 2) a


-- Stackoverflowsta apuja
