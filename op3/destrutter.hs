module Exercise where

destutter :: Eq a => [a] -> [a]
destutter [] = []
destutter (x:y:xs) | x == y =let y:ys = destutter (x:xs) in y:ys
                   | otherwise = x:destutter (y:xs)
destutter (x:xs) = [x]

