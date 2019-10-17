module Exercise where

  delete :: a -> [a] -> [a]
  delete _ [] = []
  delete a (x:xs)
      | a == x    = xs
      | otherwise = x : delete a xs
      
   
  takeEvens :: [Int] -> [Int]
  takeEvens (x:xs) =  filter even (x:xs) 
  
  -- https://stackoverflow.com/questions/3938438/merging-two-lists-in-haskell
  (+++) :: [Int] ->  [Int] ->  [Int]
  (+++) xs     []     = xs
  (+++) []     yn     = yn
  (+++) (x:xs) (y:yn) = x : y : (+++) xs yn
  
  
  
  myConcat :: [[Int]] -> [Int]
  myConcat = concat
  