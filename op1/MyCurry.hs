module MyCurry  where

  --curry1 :: ((Double, Double) -> Double) -> Double -> Double -> Double
  curry1 f x y = f (x,y)

  --uncurry1 :: (Double -> Double -> Double) -> (Double, Double) -> Double 
  uncurry1 f (a,b) = f a b
