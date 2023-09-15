
main :: IO()
main = do
    print (mymin 16 11)
    print (mymin 1 1)
    print (isInside 3 1 5)
    print (isInside 3 1 2)
    print (func 3 4)
    print (func2 3 4)
    print (myFib 5)
    print (myFibIter 5)
    print (myGcd 6 24)
    print (myGcd 1 7)
    print (myGcd 2 3)
    print (maxDivivsor 8)
    print (maxDivivsor 7)
    print (sumOdd 2 9)
    print (isPrime 1)
    print (isPrime 2)
    print (isPrime 3)
    print (isPrime 36)
    print (isPrime 17)
    print (countPalindromes 1 9)
    print (countPalindromes 10 22)
    print (countDivisors 6)
    print (countDivisors 7)
    print (countDivisors 1)

mymin :: Int -> Int -> Int
mymin a b = if a < b then a else b

isInside :: Double -> Double -> Double -> Bool
isInside x a b = a <= x && x <= b

func :: Double -> Double -> Double
func a b = (a * a + b * b ) / 2

func2 :: Double -> Double -> Double
func2 a b = average (square a) (square b)
    where
        average a b = (a + b) / 2
        square x = x * x

myFib :: Int -> Int
myFib n
    | n == 0 = 1
    | n == 1 = 1
    | otherwise = myFib (n - 1) + myFib (n - 2)

myFibIter :: Int -> Int
myFibIter n = helper 0 0 1
    where
        helper i next current
            | i > n = next
            | otherwise = helper (i + 1) (current + next) next

myGcd :: Int -> Int -> Int
myGcd a b
    | a > b = myGcd (a - b) b
    | a < b = myGcd a (b - a)
    | otherwise = a

maxDivivsor :: Int -> Int
maxDivivsor n = helper (n - 1)
    where
        helper d
            | n  `mod` d == 0 = d
            | otherwise = helper (d - 1)

sumOdd :: Int -> Int -> Int
sumOdd a b
    | a > b = 0
    | a `mod` 2 == 1 = a + sumOdd (a + 1) b
    | otherwise = sumOdd (a + 1) b

isPrime :: Int -> Bool
isPrime 1 = False
isPrime n = helper 2
    where
        helper d
            | d == n = True
            | n `mod` d == 0 = False
            | otherwise = helper (d + 1)

countPalindromes :: Int -> Int -> Int
countPalindromes a b
    | a > b = 0
    | isPalindrome a = 1 + countPalindromes (a + 1) b
    | otherwise = countPalindromes (a + 1) b
    where
        reverse k res =
            if k < 10
            then res * 10 + k
            else reverse (k `div` 10) (res * 10 + (k `mod` 10))
        isPalindrome a = a == reverse a 0

countDivisors :: Int -> Int
countDivisors n = helper 1 0
    where
        helper i result
            | i > n = result
            | n `mod` i == 0 = helper (i + 1) (result + 1)
            | otherwise = helper (i + 1) result
