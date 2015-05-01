multThree :: Int -> Int -> Int -> Int
multThree x y z = x * y * z

-- Write to REPL
-- let multTwoWithNine = multThree 9


compareToHundred :: Int -> Ordering
compareToHundred x = compare 100 x

compareToHundred' :: Int -> Ordering
compareToHundred' = compare 100

divideByTen :: (Floating a) => a -> a
divideByTen = (/10)

isUpperAlphanum :: Char -> Bool
isUpperAlphanum = (`elem` ['A'..'Z'])

applyTwice :: (a -> a) -> a -> a
applyTwice f a = f (f a)


zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

-- flip' :: (a -> b -> c) -> (a -> c -> b)
-- flip' f = g
--     where g x y = f x y
flip' :: (a -> b -> c) -> b -> a -> c
flip' f x y = f y x

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' f (x:xs)
    | f x       = x : filter' f xs
    | otherwise = filter' f xs

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallOrEquals = filter (<= x) xs
        large = filter (> x) xs
    in quicksort smallOrEquals ++ [x] ++ quicksort large

largestDivisible :: Integer
largestDivisible = head (filter p [100000,99999..])
    where p x = x `mod` 3829 == 0

sumFilteredList :: Integer
sumFilteredList = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))

sumFilteredList' :: Integer
sumFilteredList' = sum (takeWhile (<10000) [xs | x <- [1..], let xs = x ^ 2, odd xs])

chain :: Integer -> [Integer]
chain 1 = [1]
chain n
    | even n = n : chain (n `div` 2)
    | odd n  = n : chain (n * 3 + 1)

numLongChains :: Int
numLongChains = length (filter isLong (map chain [1..100]))
    where isLong xs = length xs > 15
