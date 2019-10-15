f1 :: (Int,Char,Bool) ->  Char
f1 (num, letter, bool) = letter 

f2 :: (a,b,c) -> b
f2 (a,b,c) = case(a,b,c) of  
      (_,x,_) ->  x

f3 :: (a,(b,c,d),e) -> c
f3 (a,(b,c,d),e) = c

f4 :: [a] -> Maybe a
f4 list = case list of
        [] -> Nothing
        y:_ -> Just y

f5 :: Either Int String -> String
f5 muuttuja = case muuttuja of
            Left _ -> "asd"
            Right str -> str

f6 :: Either a b -> Maybe b
f6 ataib = case ataib of
            Left _ -> Nothing
            Right b -> Just b

g1 :: Maybe a -> b ->  (Either a b)
g1 x y = case x of 
      Nothing -> Right y
      Just z -> Left z

g2 :: a -> b ->  (a,b)
g2 a b = (a,b)

g3 :: a -> b ->  (Either a b)
g3  a b = let 
          aa = Left a
          bb = Right b
          in aa