
main :: IO()
main = do
    print (incrementAllBy [1, 2, 3] 1)
    print (incrementAllBy2 [1, 2, 3] 1)
    print (multiplyAllBy [1, 2, 3] 3)
    print (filterSmallerThan [2, 4, 6, 10, 11] 7)
    print (filterSmallerThan2 [2, 4, 6, 10, 11] 7)
    print (isAccending 78)
    print (isAccending 781)
    print (isAccending 789)

incrementAllBy :: [Int] -> Int -> [Int]
incrementAllBy [] _ = []
incrementAllBy (x : xs) a = (x + a) : incrementAllBy xs a

incrementAllBy2 :: [Int] -> Int -> [Int]
incrementAllBy2 xs a = [x + a | x <- xs]

multiplyAllBy :: [Int] -> Int -> [Int]
multiplyAllBy xs a = [x * a | x <- xs]

filterSmallerThan :: [Int] -> Int -> [Int]
filterSmallerThan xs a
    | null xs = []
    | head xs < a = filterSmallerThan (tail xs) a
    | otherwise = (head xs) : filterSmallerThan (tail xs) a

filterSmallerThan2 :: [Int] -> Int -> [Int]
filterSmallerThan2 xs a = [x | x <- xs, x >= a]

isAccendingList :: [Int] -> Bool
isAccendingList xs
    | null xs || null (tail xs) = True
    | head xs > head (tail xs) = False
    | otherwise = isAccendingList (tail xs)

numToList :: Int -> [Int]
numToList n = 
    if n < 10
    then [n]
    else n `mod` 10 : numToList (n `div` 10)

reverseList :: [Int] -> [Int]
reverseList [] = []
reverseList xs = reverseList (tail xs) ++ [head xs]

isAccending :: Int -> Bool
isAccending n = isAccendingList (reverseList (numToList n))