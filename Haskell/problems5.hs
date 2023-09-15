
main :: IO()
main = do
    print (getClosestPoint points p)
    print (size t1)
    print (height t1)
    print (sumTree t1)
    print (sumLeaves t1)
    print (inorder t1)
    print (getLevel 1 t1)

data Point = Point2D Double Double | Point3D Double Double Double
    deriving (Eq, Show)

distance :: Point -> Point -> Double
distance (Point2D x1 y1) (Point2D x2 y2) = 
    sqrt ((x1 - x2) * (x1 - x2) +  (y1 - y2) * (y1 - y2))
distance (Point3D x1 y1 z1) (Point3D x2 y2 z2) = 
    sqrt ((x1 - x2) * (x1 - x2) +  (y1 - y2) * (y1 - y2) + (z1 - z2) * (z1 - z2))
distance _ _ = error "Not compatible points"

getClosestPoint :: [Point] -> Point -> Point
getClosestPoint [] _ = error "Empty list"
getClosestPoint points p = foldl1 (\ p1 p2 -> if (distance p p1) < (distance p p2) then p1 else p2) points

points :: [Point]
points = Point2D 1 1 : Point2D 2 2 : [Point2D 1 3]

p :: Point
p = Point2D 0 0

data BTree = Empty | Node Int BTree BTree deriving Show

t1 :: BTree
t1 = Node 5
        (Node 2 Empty (Node 3 Empty Empty))
        (Node 6 Empty Empty)

size :: BTree -> Int
size Empty = 0
size (Node _ lt rt) = 1 + (size lt) + (size rt)

height :: BTree -> Int
height Empty = 0
height (Node _ lt rt) = 1 + max (height lt) (height rt)

sumTree :: BTree -> Int
sumTree Empty = 0
sumTree (Node v lt rt) = v + (sumTree lt) + (sumTree rt)

sumLeaves :: BTree -> Int
sumLeaves Empty = 0
sumLeaves (Node v Empty Empty) = v
sumLeaves (Node _ lt rt) = sumLeaves lt + sumLeaves rt

inorder :: BTree -> [Int]
inorder Empty = []
inorder (Node v lt rt) = (inorder lt) ++ [v] ++ (inorder rt)

getLevel :: Int -> BTree -> [Int]
getLevel _ Empty = []
getLevel 0 (Node v _ _) = [v] 
getLevel n (Node _ lt rt) = getLevel (n - 1) lt ++ getLevel (n - 1) rt

mirrorTree :: BTree -> BTree
mirrorTree Empty = Empty
mirrorTree (Node v lt rt) = Node v (mirrorTree rt) (mirrorTree lt)