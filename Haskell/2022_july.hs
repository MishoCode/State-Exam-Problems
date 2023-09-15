
main :: IO()
main = do
    print $ maxByLength [[1], [], [1, 2, 3, 4, 5], [1, 2, 3]]
    print $ maxChain ["Boyan"] 15 "Maria" dues -- ["Maria","Sia","Boyan"]
    print $ maxCircle dues -- ["Boyan","Georgi","Petar","Maria"]

{-
Група приятели отиват на екскурзия и се редуват да плащат общите сметки. Когато се прибират,
установяват, че всеки дължи на някого дребна сума пари. Всяко задължение се представя с кортеж
от три елемента: длъжник (низ), сума (цяло положително число) и получател (низ). За Scheme под
“кортеж” се има предвид просто списък. “Верига” наричаме последователност от различни хора, в
която всеки дължи на предишния една и съща сума. “Кръг” наричаме затворена верига, т.е. верига, в
която първият дължи на последния същата сума. Приятелите се сещат, че ако в задълженията им има
верига, то може последният човек в нея да се издължи директно на първия, а ако има кръг, то всички
задължения в него се погасяват. Да се попълнят празните полета по-долу така, че:
а) функцията maxByLength да намира най-дълъг списък в списъка от списъци ls;
б) рекурсивната функция maxChain да намира най-дълга верига, завършваща със списъка chain,
сума amount и краен получател (т.е. първи елемент) final при даден списък от задължения dues;
в) функцията maxCircle да намира най-дълъг кръг при даден списък от задължения dues.
За всички функции, ако има няколко различни отговора с еднаква дължина, не е от значение кой от
тях ще бъде върнат като резултат, а ако няма нито един отговор, да се връща празният списък.
Упътване: могат да се използват наготово всички функции в R5RS за Scheme и в Prelude за Haskel -}

maxByLength :: [[a]] -> [a]
maxByLength ls = foldr (\l1 l2 -> if length l1 > length l2 then l1 else l2) [] ls

maxChain :: [String] -> Int -> String -> [(String, Int, String)] -> [String]
maxChain chain@(last:rest) amount final dues
    | last == final = chain
    | otherwise = maxByLength [
        maxChain (receiver:chain) amount final dues |
        (giver, due, receiver) <- dues, amount == due, last == giver, not (receiver `elem` rest)
    ]

maxCircle :: [(String, Int, String)] -> [String]
maxCircle dues = maxByLength [maxChain [receiver] due giver dues | (giver, due, receiver) <- dues]

dues = [("Georgi",10,"Boyan"),("Boyan",15,"Sia"),("Sia",15,"Maria"),("Maria",10,"Georgi"),
        ("Maria",10,"Petar"),("Petar",10,"Georgi"),("Boyan",10,"Maria")]