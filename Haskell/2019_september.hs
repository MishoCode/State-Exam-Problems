
main :: IO()
main = do
    print $ concatMap (\x -> [x+1, x+2, x+3]) [1, 2, 3] --[2, 3, 4, 3, 4, 5, 4, 5, 6]

    print $ addIfNew 3 [7, 8] -- [3, 7, 8]
    print $ addIfNew 3 [3, 7, 8] -- [3, 7, 8]
    print $ annotate db [evaluation, purity]
--[ ("scheme", [ ("macros", "true"), ("typing", "dynamic"), ("evaluation", "strict") ] ),
--("haskell", [ ("evaluation", "lazy"), ("pure", "true"), ("typing", "static") ] ),
--("c++", [ ("evaluation", "strict"), ("macros", "true") ] ) ]

{-
“Етикет” наричаме наредена двойка от низове — име и стойност, а “анотирана данна” наричаме
наредена двойка от данна и списък от етикети за нея. Разглеждаме база данни, представена като
списък от анотирани низове. “Анотатор” наричаме функция, която приема данна (низ) и връща списък
от етикети за нея. Да се попълнят по подходящ начин празните полета по-долу, така че при подаване
на база данни db и списък от анотатори annotators, функцията annotate да връща актуализирана база
данни, в която за всяка данна в db са добавени етикетите, върнати за нея от анотаторите в annotators.
Ако даден етикет вече съществува за дадена данна, той да не се добавя повторно. Да се реализира
помощната функция addIfNew, така че да добавя елемента в x в началото на списъка l само ако x не се
среща вече в l.
Упътване: могат да се използват наготово функциите append, apply, concat, concatMap, elem,
filter, foldr, map, member, sum и стандартните функции в R5RS за Scheme и в Prelude за Haskell. -}

addIfNew :: Eq a => a -> [a] -> [a]
addIfNew x l = if not (x `elem` l) then (x : l) else l

annotate db annotators = 
    map 
    (\(item, labels) ->(item, foldr addIfNew labels
        (concatMap
            (\annotator -> annotator item) annotators))) db

db = [("scheme", [("typing", "dynamic"), ("evaluation", "strict")]),
    ("haskell", [("typing", "static")]), ("c++", [])]

evaluation "scheme" = [("evaluation", "strict"), ("macros", "true")]
evaluation "haskell" = [("evaluation", "lazy")]
evaluation "c++" = evaluation "scheme"
purity lang = if lang == "haskell" then [("pure", "true")] else []