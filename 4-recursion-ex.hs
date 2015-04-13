import Data.Char

sum' :: [Int] -> Int
sum' [] = 0
sum' (x:xs) = x + sum' xs

product' :: [Int] -> Int
product' [] = 1
product' (x:xs) = x * product' xs

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' func (x:xs) = func x : (map' func xs)

main = do
  putStrLn . show $ sum' [1, 2, 3, 4, 5]
  putStrLn . show $ product' [1, 2, 3, 4, 5]
  putStrLn . show $ map' (\x -> x + 3) [1, 2, 3]
  putStrLn $ map' toUpper "hogehoge"
