
main :: IO()
main = do
    print $ foldr1 (&&) [False, False ..] --False
    --print $ foldr1 (&&) [True, True ..] --Изразът ще предизвика безкрайно изпълнение
    print $ filter (`elem` [10..20]) [1, 5, 10, 100, 20 , 15] -- [10, 20, 15]
    print $ negate $ max 10 20 -- -20
    print $ take 4 [1, 3 ..] -- [1, 3, 5, 7]

    --(:[]) [] ---> [[]]
    --(1:) [1, 2, 3] ---> [1, 1, 2, 3]

    --map (+) [1..5] ---> it returns a list of functions from type a -> a
    -- ($ 0) is a function that pass 0 to another function(to each function from the result of map (+) [1..5])
    print (map ($ 0) (map (+) [1..5])) -- [1, 2, 3, 4, 5]

    print $ f [1, 10] -- [2, 11, 11, 20]

    print $ g [[1, 2, 3],[4, 5, 6]] -- [[1, 4], [2, 5], [3, 6]]

f l = [x + y | x <- l, y <- l]

g :: Num a => [[a]] -> [[a]]
g ([]:_) = []
g x = (map head x) : g (map tail x)
