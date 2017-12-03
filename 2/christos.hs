import Data.Char

main ::  IO()
main = do
    filecontent <- readFile "inputChristos.txt"
    let result1 = sum $ map calculateLines $ lines filecontent
    let result2 = sum $ map calculateLines2 $ lines filecontent
    print result1
    print result2
    

calculateLines :: String -> Int
calculateLines [] = 0
calculateLines xs = (getMax $ parseStringToIntList $ words xs ) - (getMin $ parseStringToIntList $ words xs)

calculateLines2 :: String -> Int
calculateLines2 [] = 0
calculateLines2 xs = getDivision $ parseStringToIntList $ words xs

getDivision :: [Int] -> Int 
getDivision [] = 0
getDivision (x:[]) = 0
getDivision xs = getMax(([(isDivisible a b) | a <- xs, b<-xs, a /= b && mod a b == 0]))

isDivisible :: Int -> Int -> Int
isDivisible a b   | a `mod` b == 0 = a `div` b
                    | otherwise = 0

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
