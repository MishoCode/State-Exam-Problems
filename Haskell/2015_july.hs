

main :: IO()
main = do
    print $ result -- [3, 7]
    print $ [zip [x] [x] | x <- [1..5]] -- [[(1, 1)], [(2, 2)], [(3, 3)], [(4, 4)], [(5, 5)]]
    print $ map (\(x : y : z) -> x : z) [[1, 2, 3], [2, 3, 1], [3, 1, 2]] -- [[1, 3], [2, 1], [3, 2]]

    
result = map (head [(\couple -> fst couple + snd couple)]) (foldr1 (++) [[(1, 2)], [(3, 4)]])