module Main where
  import Graphics.Gloss
  import Graphics.Gloss.Interface.Pure.Game
  import Graphics.Gloss.Interface.Pure.Simulate
  import Graphics.Gloss.Interface.Pure.Display
  import Graphics.Gloss.Data.Picture

 
  data AsteroidWorld = Play [Rock] Ship Ufo [Bullet]
                     | GameOver 
                     deriving (Eq,Show)
  
  type Velocity     = (Float, Float)
  type Size         = Float
  type Age          = Float
  type Health       = Integer
  type UfoState     = Either
  
  
  
  
  data Ship   = Ship   PointInSpace Velocity      
      deriving (Eq,Show)
  data Bullet = Bullet PointInSpace Velocity Age  
      deriving (Eq,Show)
  data Rock   = Rock   PointInSpace Size Velocity
      deriving (Eq,Show)
  --Change 
  data Ufo   = Ufo   PointInSpace Velocity Health    
      deriving (Eq,Show)
  
  initialWorld :: AsteroidWorld
  initialWorld = Play
                     [Rock (150,150)  45 (2,6)  
                     ,Rock (-45,201)  45 (13,-8) 
                     ,Rock (45,22)    25 (-2,8)  
                     ,Rock (-210,-15) 30 (-2,-8) 
                     ,Rock (-45,-201) 25 (8,2)  
                     ] -- The default Rocks
                     (Ship (0,0) (0,5))
                     -- The initial ship
                     (Ufo (120,120) (2,6) 3) -- Ufo --Change
                     [] -- The initial bullets (none)
  
  
  simulateWorld :: Float -> (AsteroidWorld -> AsteroidWorld)
  
  simulateWorld _        GameOver          = GameOver  
  
  simulateWorld timeStep (Play rocks (Ship shipPos shipV) (Ufo ufoPos ufoV ufoHealth) bullets)  --Change
    | any (collidesWith shipPos) rocks  = GameOver
    | otherwise = Play (concatMap updateRock  rocks) 
                                (Ship newShipPos shipV)
                                (updateUfo ( Ufo newUfoPos ufoV ufoHealth)) --Change
                                (concat (map updateBullet bullets))
    where
        collidesWith :: PointInSpace -> Rock -> Bool
        collidesWith p (Rock rp s _) 
         = magV (rp .- p) < s

        ufoCollidesWith :: PointInSpace -> Ufo -> Bool
        ufoCollidesWith p (Ufo rp   _ s) 
         = magV (rp .- p) < 20
  
        collidesWithBullet :: Rock -> Bool
        collidesWithBullet r 
         = any (\(Bullet bp _ _) -> collidesWith bp r) bullets

         -- Muutos 2
        ufoCollidesWithBullet :: Ufo -> Bool
        
        ufoCollidesWithBullet r 
         = let asd = putStrLn "hello, world"
         in any (\(Bullet bp _ _) -> ufoCollidesWith bp r) bullets  


        updateUfo :: Ufo ->  Ufo 
        updateUfo u@(Ufo p v h) 
         | ufoCollidesWithBullet u && h < 1
         =  (Ufo (-100000,0) v h) 
         
         | ufoCollidesWithBullet u 
           =  (damageUfo u)
         
         | otherwise
           =  u 
       
       
        updateRock :: Rock -> [Rock]
        updateRock r@(Rock p s v) 
         | collidesWithBullet r && s < 7 
              = []
         | collidesWithBullet r && s > 7 
              = splitRock r
         | otherwise                     
              = [Rock (restoreToScreen (p .+ timeStep .* v)) s v]
   
        updateBullet :: Bullet -> [Bullet] 
        updateBullet (Bullet p v a) 
          | a > 5                      
               = []
          | any (collidesWith p) rocks 
               = [] 
          | otherwise                  
               = [Bullet (restoreToScreen (p .+ timeStep .* v)) v 
                         (a + timeStep)] 
  
        newShipPos :: PointInSpace
        newShipPos = restoreToScreen (shipPos .+ timeStep .* shipV)

        newUfoPos :: PointInSpace
        newUfoPos = restoreToScreen (ufoPos .+ timeStep .* ufoV)
  
  splitRock :: Rock -> [Rock]
  splitRock (Rock p s v) = [Rock p (s/2) (3 .* rotateV (pi/3)  v)
                           ,Rock p (s/2) (3 .* rotateV (-pi/3) v) ]

  damageUfo :: Ufo -> Ufo
  damageUfo (Ufo p v h) = (Ufo p v (h-1))
  
  restoreToScreen :: PointInSpace -> PointInSpace
  restoreToScreen (x,y) = (cycleCoordinates x, cycleCoordinates y)
  
  cycleCoordinates :: (Ord a, Num a) => a -> a
  cycleCoordinates x 
      | x < (-400) = 800+x
      | x > 400    = x-800
      | otherwise  = x
  
  drawWorld :: AsteroidWorld -> Picture
  
  drawWorld GameOver 
     = scale 0.15 0.2 
       . translate (-400) 0
       . color red 
       . text 
       $ "Game Over! Right Clik to Play!" --Change 1
  
  drawWorld (Play rocks (Ship (x,y) (vx,vy)) (Ufo (a,b) (ax,ay) h) bullets) --Change
    = pictures [ship, asteroids,ufo,shots]
     where 
      ship      = color red (pictures [translate x y (ThickCircle 10 20)])
      ufo      = color green (pictures [translate a b (ThickCircle 20 15)]) --Change
      asteroids = pictures [translate x y (color orange (ThickCircle s (s/5))) 
                           | Rock   (x,y) s _ <- rocks]
      shots     = pictures [translate x y (color violet (circle 2)) 
                           | Bullet (x,y) _ _ <- bullets]
  
  handleEvents :: Event -> AsteroidWorld -> AsteroidWorld

  --Change 2
  handleEvents (EventKey (MouseButton RightButton) _ _ _) GameOver =  initialWorld
  handleEvents _ GameOver = GameOver

  
  
  

  handleEvents (EventKey (MouseButton LeftButton) Down _ clickPos)
               (Play rocks (Ship shipPos shipVel) (Ufo ufoPos ufoVel ufoHealth) bullets) --Change
               = Play rocks (Ship shipPos newVel) (Ufo ufoPos newUfoVel ufoHealth)--Change
                            (newBullet : bullets)
   where 
       newBullet = Bullet shipPos 
                          (negate 150 .* norm (shipPos .- clickPos)) 
                          0
       newVel    = shipVel .+ (50 .* norm (shipPos .- clickPos))
       -- 
       newUfoVel = if ufoHealth > 2 then (shipVel .+ (100 .* norm (shipPos .- clickPos  ))) 
        else (shipVel .+ (-100 .* norm (shipPos .- clickPos  )))  
  
  handleEvents _ w = w
  
  type PointInSpace = (Float, Float)
  (.-) , (.+) :: PointInSpace -> PointInSpace -> PointInSpace
  (x,y) .- (u,v) = (x-u,y-v)
  (x,y) .+ (u,v) = (x+u,y+v)
  
  (.*) :: Float -> PointInSpace -> PointInSpace
  s .* (u,v) = (s*u,s*v)
  
  infixl 6 .- , .+
  infixl 7 .*
  
  norm :: PointInSpace -> PointInSpace
  norm (x,y) = let m = magV (x,y) in (x/m,y/m)
  
  magV :: PointInSpace -> Float
  magV (x,y) = sqrt (x**2 + y**2) 
  
  limitMag :: Float -> PointInSpace -> PointInSpace
  limitMag n pt = if (magV pt > n) 
                    then n .* (norm pt)
                    else pt
  
  rotateV :: Float -> PointInSpace -> PointInSpace
  rotateV r (x,y) = (x * cos r - y * sin r
                    ,x * sin r + y * cos r)
  
  
  main = play 
           (InWindow "Asteroids!" (550,550) (20,20)) 
           black 
           24 
           initialWorld 
           drawWorld 
           handleEvents
           simulateWorld
           
  