
main :: IO()
main = do
    print (reverseOrdSuff 37563)
    print (reverseOrdSuff 32763)
    print (reverseOrdSuff 32567)
    print (reverseOrdSuff 37666)

    print (sumUnique [[1,2,3,2],[-4,-4],[5]])
    print (sumUnique  [[2,2,2],[3,3,3],[4,4,4]])
    print (sumUnique  [[1,2,3],[4,5,6],[7,8,9]])

largestPrefix :: [Int] -> [Int]
largestPrefix [] = []
largestPrefix [x] = [x]
largestPrefix (x1 : x2 : xs) =
    if x1 >= x2 then [x1] else x1 : largestPrefix (x2 : xs)

numToListRev :: Int -> [Int]
numToListRev n = if n < 10 then [n] else (n `mod` 10) : (numToListRev (n `div` 10))

listToNum :: [Int] -> Int
listToNum xs = foldl (\ num rest -> 10 * num + rest) 0 xs

reverseOrdSuff :: Int -> Int
reverseOrdSuff k = listToNum $ largestPrefix $ numToListRev k


count :: Int -> [Int] -> Int
count _ [] = 0;
count x xs = length (filter (x ==) xs)

sumOfUniques :: [Int] -> Int
sumOfUniques xs = sum [x | x <- xs, count x xs == 1]

sumUnique :: [[Int]] -> Int
sumUnique xs = sum (map sumOfUniques xs)

