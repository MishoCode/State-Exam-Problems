

main :: IO()
main = do
    print $ sumMaxRoots (\x -> x^3 - x) [ [1, 2, 3], [-1, 0, 5], [1, 4, -1] ] -- -1
    print $ sumMaxRoots (\x -> x^3 - x) [ [1, 2, 3], [3, 3, 5], [1, 4, -1] ] -- 0
    print $ sumMaxRoots (\x -> x^3 - x) [ [10, 2, 3], [3, 3, 5], [10, 4, 5] ] -- 0

{-
Даден е списък от списъци от числа ll и числова функция f. Числото x наричаме “корен” на f, ако 
f(x) = 0. Да се попълнят по подходящ начин празните полета по-долу, така че функцията sumMaxRoots 
да намира сумата на корените на f  в този списък от ll, в който f има най-много корени. Ако има няколко 
такива списъка, функцията да връща сумата на корените в първия по ред списък. Ако функцията няма 
корен сред числата в списъците на ll, функцията да връща 0. 
Упътване: можете да използвате наготово функциите apply, filter, foldr, length, map, max, maximum, 
както и всички стандартни функции в R5RS за Scheme и Prelude за Haskell. -}

selectList :: Num a => [a] -> [a] -> [a]
selectList l1 l2 = if length l1 >= length l2 then l1 else l2

sumMaxRoots :: (Num a, Eq a) => (a -> a) -> [[a]] -> a
sumMaxRoots f ll =
    sum
        (foldr selectList []
            (map (\l -> [x | x <- l, f x == 0]) ll))