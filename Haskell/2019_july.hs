
main :: IO()
main = do
    print $ recommended basket bestFit1 products -- [7, 3, 6]
    print $ recommended basket bestFit2 products -- [7, 3]
    print $ recommended basket bestFit3 products -- [7, 7]

{-
Големият онлайн магазин Siberia търси начин да увеличи продажбите като препоръчва на клиентите 
си подходящи продукти. За целта изследователският екип на Siberia  експериментира с различни 
реализации на функция bestFit, която приема като параметър код на продукт a  и връща код на 
друг продукт b, който клиентите на магазина най-вероятно биха си купили заедно с a. Задачата пред 
разработчиците на Siberia е да реализират функция recommended, която получава като параметри 
потребителска кошница basket (списък от целочислени кодове на продукти), функция bestFit и 
списък от продуктите на магазина products  (списък от наредени двойки от уникален код на 
продукт и цена — неотрицателно число). 
Да се попълнят по подходящ начин празните полета по-долу така, че функцията recommended да 
връща списък от кодовете на всички възможни препоръчани продукти. Допуска се в резултата някои 
кодове да се срещат повече от веднъж. Препоръчан продукт е такъв, който: 
● все още не е в basket, но се получава като резултат от прилагането на функцията bestFit 
над някой от продуктите, които вече са в basket; 
● има цена, която не надвишава общата цена на потребителската кошница, дефинирана като 
сумата от цените на продуктите в basket. 
Помощните дефиниции findPrice  и basketCost  намират съответно цената на даден продукт 
product  в списъка products  и цената на потребителската кошница. Да се приеме, че basket 
съдържа само кодове на продукти в products и bestFit също връща само такива кодове. 
Упътване: могат да се използват наготово функциите apply, assoc, elem, filter, foldr, lookup, 
map, member, sum и  стандартните  функции  в  R5RS  за  Scheme  и  в  Prelude  за  Haskell. -}

recommended :: [Int] -> (Int -> Int) -> [(Int, Int)] -> [Int]
recommended basket bestFit products = 
    filter
    (\product ->
        not (product `elem` basket) && (findPrice product) < basketCost)
    (map bestFit basket)
    where
        findPrice product = let Just val = lookup product products in val
        basketCost = sum (map findPrice basket)

products = [(1, 10), (2, 5), (3, 7), (4, 10), (5, 27), (6, 11), (7, 2)]
basket = [1, 2, 4] -- The cost is 25

bestFit1 1 = 7
bestFit1 2 = 3
bestFit1 4 = 6

bestFit2 1 = 7
bestFit2 2 = 3
bestFit2 4 = 5

bestFit3 1 = 7
bestFit3 2 = 4
bestFit3 4 = 7
bestFit 5 = 3