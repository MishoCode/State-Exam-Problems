
main :: IO()
main = do
    print $ treeWords t
    
    print $ quickSort [4, 3, -8, 11, 12, 100, 1]
    print $ quickSort ([] :: [Int])
    print $ quickSort [1, 1, 1]



data Tree a = EmptyTree |  Node {
    value :: a,
    left :: Tree a,
    right :: Tree a
} deriving (Show, Read)

{-
Довършете функцията treeWords:
1. Опишете типа на функцията така, че тя да получава дърво от символи и да връща списък от
символни низове.
2. Функцията да връща списък от всички думи, които могат да се образуват по път от корена до
някое от листата на дървото. Ако дървото е празно, да се връща празният списък. -}

treeWords :: Tree Char -> [String]
treeWords EmptyTree = []
treeWords (Node v EmptyTree EmptyTree) = [[v]]
treeWords (Node v l r) = map (v:) ( wl ++ wr)
    where
        wl = treeWords l
        wr = treeWords r

t :: Tree Char
t = Node 'a'
        (Node 'a' EmptyTree (Node 'b'  EmptyTree EmptyTree))
        (Node 'c' (Node 'd' EmptyTree EmptyTree) (Node 'e' EmptyTree EmptyTree))

{-
Довършете кода на функцията quickSort така, че тя да сортира списък по метода на бързото
сортиране (quicksort). Опишете типа на функцията по такъв начин, че тя да може да работи със списък
от произволен тип елементи, стига те да са от класа Ord. -}

quickSort :: Ord a => [a] -> [a]
quickSort [] = []
quickSort (x : xs) = (quickSort lesser) ++ [x] ++ (quickSort greater)
    where
        lesser = filter (\y -> y <= x)  xs
        greater = filter (\y -> y > x) xs