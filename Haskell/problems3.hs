
main :: IO()
main = do
    print (isImage [1, 2, 3] [4, 5, 6])
    print (isImage [1, 2, 3] [7, 11, 8])
    print (chunksOf 4 [1..15])
    print (isTriangular [[1, 2, 3], [0, 5, 6], [0, 0, 9]])
    print (isTriangular [[1, 2, 3], [0, 0, 0], [0, 0, 9]]) 
    print (isTriangular [[1, 2, 3], [0, 5, 6], [7, 0, 9]])
    print (divisors 6)
    print (divisors 1)
    print (divisors 7)
    print (primesInRange 3 12)
    print (prodSumDiv [2, 3, 6, 9] 2)
    print (prodSumDiv [2, 3, 5] 5)
    print (isSorted [1, 2, 3, 4, 5, 6, 7])
    print (isSorted [3, 4, 1])
    print (merge [1, 4, 9] [2, 3, 10])
    print (insert 3 [1, 4, 9])
    print (insert 0 [1, 4, 9])
    print (insert 10 [1, 4, 9])
    print (insertionSort [4, 8, 11, 2, 1, 7])
    print (insertionSort2 [4, 8, 11, 2, 1, 7])


isImage :: [Int] -> [Int] -> Bool
isImage [_] [_] = True
isImage (a1 : a2 : as) (b1 : b2 : bs) = a1 - b1 == a2 - b2 && isImage (a2 : as) (b2 : bs)

chunksOf :: Int -> [a] -> [[a]]
chunksOf _ [] = []
chunksOf n xs = take n xs : chunksOf n (drop n xs)

isTriangular :: [[Int]] -> Bool
isTriangular [] = False
isTriangular [[_]] = True
isTriangular mat = all (==0) (tail (map head mat)) && isTriangular (tail (map tail mat))

divisors :: Int -> [Int]
divisors n = [d | d <- [1..n - 1], n `mod` d == 0]

isPrime :: Int -> Bool
isPrime 1 = False
isPrime n = helper 2
    where
        helper d
            | d == n = True
            | mod n d == 0 = False
            | otherwise = helper (d + 1)

primesInRange :: Int -> Int -> [Int]
primesInRange a b = [p | p <- [a..b], isPrime p]


prodSumDiv :: [Int] -> Int -> Int
prodSumDiv xs k = product [x | x <- xs, mod (sum (divisors x)) k == 0]

isSorted :: [Int] -> Bool
isSorted [] = True
isSorted [_] = True
isSorted (x1 : x2 : xs) = x1 <= x2 && isSorted (x2 : xs)

merge :: [Int] -> [Int] -> [Int]
merge xs [] = xs
merge [] xs = xs
merge (a : as) (b : bs) = 
    if a <= b
    then a : (merge as (b : bs))
    else b : (merge (a : as) bs)

insert :: Int -> [Int] -> [Int]
insert x [] = [x]
insert x xs@(a : as) = 
    if a > x
    then x : xs
    else a : insert x as

insertionSort :: [Int] -> [Int]
insertionSort xs = helper [] xs
    where
        helper result [] = result
        helper result (x : xs) = helper (insert x result) xs

insertionSort2 :: [Int] -> [Int]
insertionSort2 = foldr insert []

