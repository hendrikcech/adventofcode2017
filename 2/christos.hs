import Data.Char


main ::  IO()
main = do
    filecontent <- readFile "inputChristos.txt"
    let result = sum $ map calculateLines $ lines filecontent
    print result
    
isPalindrome w = w==reverse w

calculateLines :: String -> Int
calculateLines [] = 0
calculateLines xs = (getMax $ parseStringToIntList $ words xs ) - (getMin $ parseStringToIntList $ words xs)

parseStringToIntList :: [String] -> [Int]
parseStringToIntList xs = map (read) xs 

getMax :: [Int] -> Int
getMax []  = 0
getMax (x:[]) = x 
getMax (x:xs) = if (x) > (getMax xs) then (x) else getMax xs


getMin :: [Int] -> Int
getMin [] = 0
getMin (x:[])= x
getMin (x:xs) = if(x) < (getMin xs) then (x) else getMin xs
