

main :: IO()
main = do
    print $ [x : [x] | x <- [[1, 2], [3, 4]]] -- [[[1, 2], [1, 2]], [[3, 4], [3, 4]]]
    print $ [map (f 5) [1, 2, 3] | f <- [(+), (-), (*)]] -- [[6, 7, 8], [4, 3, 2], [5, 10, 15]]
    --print $ map (5-) [1, 2, 3] -- [4, 3, 2]
    print $ "a" : [['b', 'c'], "d"] -- ["a", "bc", "d"]