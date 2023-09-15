

main :: IO()
main = do
    --print $ all (>=1) [1, 2, 3] --True
    --print $ any (>1) [1, 2, 3] --True

    print $ twig (T 1 [T 2 [], T 3 []]) --True
    print $ stick (T 1 [T 2 [T 3 [T 4 []]]]) --True
    print $ stick (T 1 [T 2 [], T 3 []]) --False
    print $ twig (T 1 []) --True

    print $ trim tree --T 1 [T 4 [], T 7 [T 9 []]]
    print $ trim (T 1 [T 2 [T 3 [T 4 []]]]) -- T 1 [T 2 []]

    print $ prune tree --T 1 [T 2 [T 3 []], T 4 [T 5 []], T 7 [T 8 [], T 9 [T 10 []]]]
    print $ prune (T 1 [T 2 [T 3 [T 4 []]]]) -- T 1 [T 2 []]

{-
Крайно кореново дърво, всеки връх на което съдържа цяло число и може да има произ-
волен брой деца, се представя в Scheme като наредена двойка, състояща се от стойността на корена и
списък от директни поддървета, а в Haskell — със следната рекурсивна структура:
data Tree = T { root :: Int, subtrees :: [Tree] } deriving Show
Листо наричаме дърво с единствен връх, клонка наричаме дърво, чиито директни поддървета са
листа, а пръчка наричаме дърво, в което всеки връх има най-много едно дете. Казваме, че едно дърво
се подрязва, ако от него се премахнат всички клонки, с изключение на корена, и че се окастря, ако
всички пръчки в него, които са с повече от два върха и не са част от други пръчки, се скъсят откъм
листата до дължина точно два върха. Да се попълнят празните полета по-долу, така че:
•функциите leaf, twig и stick да проверяват дали дърво е съответно листо, клонка или пръчка;
•функциите trim и prune да връщат съответно подрязано или окастрено копие на дървото, пода-
дено им като параметър.
Упътване: могат да се използват наготово all, any, car, cdr, filter, foldl, foldr, head, null, null?,
tail, length, map, както и всички функции в R5RS за Scheme и в Prelude за Haskell. -}

data Tree = T {
    root :: Int,
    subtrees :: [Tree]
} deriving Show

leaf :: Tree -> Bool
leaf (T root subtrees) = null subtrees

twig :: Tree -> Bool
twig (T root subtrees) = all leaf subtrees

stick :: Tree -> Bool
stick (T _ subtrees) = null subtrees || (length subtrees == 1 && stick (head subtrees))

--stick (T _ [t]) = stick t
--stick (T _ subtrees) = null subtrees

trim :: Tree -> Tree
trim (T x ts) = T x [trim t | t <- ts, not (twig t)]

prune :: Tree -> Tree
prune t@(T x []) = t
prune t@(T x ts) = T x (
    if stick t
    then let [T y _] = ts in [T y []] -- thus we get the value of the only child of T
    else map prune ts)

{-
prune t@(T x []) = t
prune t@(T x ts) = T x (
    if stick t
    then [T y []] 
    else map prune ts)
    where
        [T y _] = ts
-}

tree = T 1 [T 2 [T 3 []], T 4 [T 5 [T 6 []]], T 7 [T 8 [], T 9 [T 10 [T 11 []]]]]