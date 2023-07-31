-- Curry with arithmetic constraints:

import CLP.R
import Test.Prop

-- Example to maximize a constraint of linear expressions:

max1 :: (CFloat,CFloat,CFloat)
max1 = maximumFor (\ (x,y,z) -> 2*x+y <= 16 & x+2*y <= 11 & x+3*y <= 15 & z =:= 30*x+50*y)
                  (\ (_,_,z) -> z)
-- > max1
-- (CF 7.0, CF 2.0, CF 310.0)

-- ...and transform the result into standard floats:
max2 :: Float
max2 = let (x,y,z) = max1
       in toFloat z
-- > max2
-- (7.0, 2.0, 310.0)

-- The same as a constraint:
max3 :: CFloat -> CFloat -> CFloat -> Bool
max3 a b c =
  maximize (\ (x,y,z) -> 2 * x + y <= 16 & x + 2 * y <= 11 & x + 3 * y <= 15 &
                         z =:= 30 * x + 50 * y)
           (\ (_,_,z) -> z) 
           (a, b, c)
-- > max2 (fromFloat a) (fromFloat b) (fromFloat c) where a,b,c free
-- {x=7.0, y=2.0, z=310.0} True


-- Testing:
testMax4 :: Prop
testMax4 = always $ abs (max2 - 310) < 0.01
