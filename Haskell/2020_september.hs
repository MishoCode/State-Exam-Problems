

main :: IO()
main = do
    print $ rf ("Mozart","The Marriage of Figaro Overture",270) -- "Summertime"
    print $ rf ("Gershwin", "Summertime", 300) -- "Rhapsody in Blue"
    print $ rf ("Gershwin", "Rhapsody in Blue", 1100) -- "Bohemian Rhapsody" 

recommender :: [(String, String, Int)] -> ((String, String, Int) -> String)
recommender pl = \(author, title, len) -> 
    let avgDuration artist = fromIntegral (sum [l | (a, t, l) <- pl, a == artist]) / fromIntegral (length [l | (a, t, l) <- pl, a == artist]) 
        option1 = [t | (a, t, l) <- pl, a == author, l > len]
        option2 = [t | (a, t, l) <- pl, not (a == author), avgDuration author > avgDuration a]
    in if not (null option1) then (head option1)
        else if not (null option2) then (head (reverse option2))
            else if null [t | (a, t, l) <- pl, not (a == author), l > len] then title else head [t | (a, t, l) <- pl, not (a == author), l > len]


rf = recommender [
    ("Mozart","The Marriage of Figaro Overture",270),
    ("Gershwin","Summertime",300),
    ("Queen","Bohemian Rhapsody",355),
    ("Gershwin","Rhapsody in Blue",1100)]


