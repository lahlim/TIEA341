-- part1

  examples = [(timeToSave 100 8 2, Just 17)
             ,(timeToSave 10  6 1, Just 2)
             ,(timeToSave 10  6 2, Just 3)
             ,(timeToSave 1  2 1, Just 1)
             ,(timeToSave 5  1 2, Nothing)]
  
  -- This here is a function that just collects your
  -- examples to a three-tuple, so the exercise checking
  -- bot can inspect them.
  timeToSave = (,,)         
             




  --part2



    timeToSave :: Double -> Double -> Double -> Maybe Int
    timeToSave goal income expenses = 
        do 
         let ammount = goal / (income-expenses)
         let ammount2 = ceiling ammount
         if income > expenses 
            then Just ammount2
         else  Nothing
             


     