-- Curry with arithmetic constraints:

import CLPR

-- Example to maximize a constraint of linear expressions:

max1 :: (Float,Float,Float)
max1 =
  maximumFor (\ (x,y,z) -> 2 *. x +. y <=. 16 & x +. 2 *. y <=. 11 & x +. 3 *. y <=. 15 &
                           z =:= 30 *. x +. 50 *. y)
             (\ (_,_,z) -> z)
-- > max1
-- (7.0, 2.0, 310.0)


-- The same as a constraint:
max2 :: Float -> Float -> Float -> Bool
max2 a b c =
  maximize (\ (x,y,z) -> 2 *. x +. y <=. 16 & x +. 2 *. y <=. 11 & x +. 3 *. y <=. 15 &
                         z =:= 30 *. x +. 50 *. y)
           (\ (_,_,z) -> z) 
           (a, b, c)
-- > max2 a b c where a,b,c free
-- {x=7.0, y=2.0, z=310.0} True
