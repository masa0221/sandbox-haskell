length' :: [a] -> Int
length' = foldl (\cnt x -> cnt + 1) 0

all' :: (a -> Bool) -> [a] -> Bool 
all' = foldl (\acc x -> if x then True else acc && False) False


main = do
    print $ length' [1,2,3,4] 
    print $ length' $ replicate 100 1
--    print $ all' even [2,4,6]
--    print $ all' even [2,4,7]
--    print $ all' even [1,3..]
