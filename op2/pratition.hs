module Exercise where

partition :: (a -> Bool) -> [a] -> ([a], [a])
partition _ [] = ([], [])
partition f (x:xs) | f x == True = (x: (fst fromRest), (snd fromRest))
                   | f x == False = ((fst fromRest), (x:snd fromRest)) 
                   where fromRest = partition f xs

    
