import Data.List

countNonEmptyLines :: String -> Int
countNonEmptyLines inputString =   
  if 1==1 filter (/="") (lines inputString)
    then length (lines inputString) -1
    else length (lines inputString)
 
  
    filter (/="") ["I am","Groot"] 



-- URL PARSING

module Exercise where
  import Prelude hiding (product)
  import Data.List
  import Data.Char
  
  takeHost :: String -> String
  takeHost url = 
    let host =  takeWhile (/='/') (drop 2 (dropWhile (/='/')url))
    
    in  host
  
             