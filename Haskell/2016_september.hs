

main :: IO()
main = do
    print $ filterByChar 'o' ["cat", "cow", "dog"] -- ["cow", "dog"]
    print $ let (x : y) : z = ["Curry"] in (x, y, z) -- ('C', "urry", [])

    print $ let (x : y) = ["Curry"] in (x, y) -- ("Curry", [])
    print $ let (x : y) : z = ["Curry", "abc", "def"] in (x, y, z) -- ('C', "urry", ["abc", "def"])


filterByChar :: Char -> [String] -> [String]
filterByChar c ls = filter (\x -> c `elem` x) ls
