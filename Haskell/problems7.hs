
main :: IO()
main = do
    print (let (x:y):z = ["Curry"] in (x,y,z))
    --print (concatMap (\x -> x ++ [1]) [[1, 2], [3, 4]])
    print (annotate db [evaluation, purity])

    print (foldr1 (&&) [False, False ..]) --False
    --print (foldr1 (&&) [True, True ..]) --Infinite execution
    print (filter (`elem` [10..20]) [1, 5, 10, 100, 20, 15]) -- [10, 20, 15]
    --print (filter (\x -> elem x [10..20]) [1, 5, 10, 100, 20, 15])
    print (negate $ max 10 20) -- -20
    print (take 4 [1, 3 ..]) -- [1, 3, 5, 7]
    print (map ($ 0)  (map (+) [1..5]))
    print (f [1, 10]) -- [2, 11, 20]
    print (g [[1, 2, 3], [4, 5, 6]]) -- [[1, 4], [2, 5], [3, 6]]

    print (leaf (T 1 []))
    print (leaf (T 1 [T 2 [], T 3 []]))

    print (twig (T 1 [T 2 [], T 3 []]))
    print (twig (T 1 [T 2 [], T 3 [T 7 []]]))

    print (stick (T 1 [T 2 [T 3 [T 4 []]]]))
    print (stick (T 1 [T 2 [T 3 [T 4 [T 11 [], T 12 []]]]]))

    print (trim tree)

f l = [x + y | x <- l, y <- l]

g :: Num a => [[a]] -> [[a]]
g ([]:_) = []
g x = (map head x) : g (map tail x)

addIfNew :: (String, String) -> [(String, String)] -> [(String, String)]
addIfNew x l =
    if elem x l then l else (x : l)

annotate db annotators =
    map (\(item, labels) -> 
        (item, foldr addIfNew labels (concatMap (\annotator -> annotator item) annotators))) db

db = [("scheme", [("typing", "dynamic"), ("evaluation", "strict")]), ("haskell", [("typing", "static")]), ("c++", [])]

evaluation "scheme" = [("evaluation", "strict"), ("macros", "true")]

evaluation "haskell" = [("evaluation", "lazy")]

evaluation "c++" = evaluation "scheme"

purity lang = if lang == "haskell" then [("pure", "true")] else []
--annotate db [evaluation, purity]
--[ ("scheme", [ ("macros", "true"), ("typing", "dynamic"), ("evaluation", "strict") ] ),
--("haskell", [ ("evaluation", "lazy"), ("pure", "true"), ("typing", "static") ] ),
--("c++", [ ("evaluation", "strict"), ("macros", "true") ] ) ]

--2022
data Tree = T { root :: Int, subtrees :: [Tree] } deriving Show

leaf :: Tree -> Bool
leaf (T root children) = null children

twig :: Tree -> Bool
twig (T root children) = all leaf children

stick :: Tree -> Bool
stick (T _ [t]) = stick t
stick (T _ children) = null children

trim :: Tree -> Tree
trim (T x ts) = T x (map trim [t | t <- ts, not $ twig t])

tree = T 1 [T 2 [T 3 []], T 4 [T 5 [T 6 []]], T 7 [T 8 [], T 9 [T 10 [T 11 []]]]]

