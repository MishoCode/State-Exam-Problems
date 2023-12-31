
main :: IO()
main = do
    print $ argMin (\x -> x + 1) [1, 2, 3] -- 1
    print $ argMin (\x -> x + 1) [1, 2, -3] -- -3
    --print $ zip [1, 2, 3, 4] [2, 3, 4] -- [(1,2),(2,3),(3,4)]
    print $ maxSlope (head tracks) -- 0.2
    print $ easiestTrackUnder 800 tracks -- [(0, 900), (100, 910), (200, 925), (300, 905), (600, 950)]

{-
При планински преход GPS устройствата могат да записват “следа” на изминатия път във вид на
поредица от поне две точки. Всяка точка се задава с наредена двойка от цели числа: изминато разстоя-
ние от началото на прехода и надморска височина. Точките в следата са подредени в строго нарастващ
ред по изминатото разстояние. “Наклон” на участъка между две точки наричаме абсолютната стойност
на отношението на разликата във височините им и дължината на изминатия път между тях.
Да се попълнят по подходящ начин празните полета в програмата по-долу, така че при извикване
на функцията easiestTrackUnder с максимална дължина maxLen и списък от следи tracks да се връща
следата, чиито максимален наклон е възможно най-малък от всички следи от tracks, които са по-къси
от maxLen. Ако има повече от една следа, отговаряща на условието, е без значение коя от тях ще бъде
върната като резултат. Ако няма нито една следа, отговаряща на условието, поведението на функцията
е недефинирано (може да бъде произволно).
Да се реализират помощните функции maxSlope, която намира максималния наклон на участък в
пътека и argMin, която намира елемента в непразния списък l, над който функцията f дава минимална
стойност.
Упътване: могат да се използват наготово функциите abs, apply, filter, foldr, foldr1, last, map,
min, minimum, max, maximum, reverse, zip, както и всички стандартни функции в R5RS за Scheme и в Prelude
за Haskell. -}


argMin :: Ord b => (a -> b) -> [a] -> a
argMin f l = foldr1 (\x y -> if (f x) < (f y) then x else y) l;

maxSlope :: [(Int, Int)] -> Double
maxSlope track =  maximum (map (\((dist1, height1), (dist2, height2)) ->
    abs $ fromIntegral (height2 - height1) / fromIntegral (dist2 - dist1))
    (zip track (tail track)))

easiestTrackUnder :: Int -> [[(Int, Int)]] -> [(Int, Int)]
easiestTrackUnder maxLen tracks = argMin maxSlope (filter (\t -> fst (head (reverse t)) < maxLen) tracks)

tracks = [[(0, 900), (100, 910), (200, 925), (300, 905), (600, 950)],
    [(0, 1300), (100, 1305), (500, 1340), (800, 1360), (1000, 1320)],
    [(0, 800), (200, 830), (300, 845), (600, 880), (800, 830)]]



