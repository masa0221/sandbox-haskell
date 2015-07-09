data Point = Point Float Float
data Triangle = Triangle Point Point Point

calcTriangleArea :: Triangle -> Float
calcTriangleArea (Triangle (Point x y) (Point a b) (Point c d)) = ((a - x) * (d - y) - (b - y) * (c - x)) / 2

main = do
    putStrLn $ show $ calcTriangleArea $ Triangle (Point 0 0) (Point 0 5) (Point 5 0) -- 12.5
    putStrLn $ show $ calcTriangleArea $ Triangle (Point 1 3) (Point 2 8) (Point (-1) 4) -- 5.5
