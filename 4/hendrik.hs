import qualified Data.Set as Set
import qualified Data.MultiSet as MSet

main :: IO ()
main = do
  file <- readFile "input.txt"
  let ls = lines file
  print $ length $ filter id $ (checkLine noAnagrams) <$> ls

checkLine :: ([String] -> Bool) -> String -> Bool
checkLine fn line = fn . words $ line

unique :: [String] -> Bool
unique = go Set.empty
  where
    go seen (x:xs) =
      if Set.member x seen
        then False
        else go (Set.insert x seen) xs
    go seen [] = True

noAnagrams :: [String] -> Bool
noAnagrams words =
  let
    wordsProduct = Main.product $ MSet.fromList <$> words
    anagrams = filter (== True) $ isAnagram <$> wordsProduct
  in
    -- wordsProduct returns a list which also pairs words with itself
    -- i.e., [w1, w2] -> [w1,w1], [w1,w2], [w2,w2]
    -- obviously, [w1,w1] and [w2,w2] are anagrams
     (length anagrams) == (length words)

isAnagram :: (MSet.MultiSet Char, MSet.MultiSet Char) -> Bool
isAnagram (x, y) = 0 == (MSet.size (x MSet.\\ y) + MSet.size (y MSet.\\ x))

product :: [a] -> [(a,a)]
product xs = [(x, y) | x <- xs, y <- xs]
