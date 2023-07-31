-- Curry with arithmetic constraints:

{-# OPTIONS_CYMAKE -Wno-overlapping #-}

import CLP.R
import Test.Prop

-- Example:
-- Mortgage relationship between:
--     p:  Principal
--     t:  Life of loan in months
--     ir: Fixed (but compounded) monthly interest rate
--     r:  Monthly repayment
--     b:  Outstanding balance at the end

mortgage :: CFloat -> CFloat -> CFloat -> CFloat -> CFloat -> Bool
mortgage p t ir r b | t > 0 & t <= 1  -- lifetime not more than 1 month?
                    =  b =:= p * (1 + t*ir) - t*r
mortgage p t ir r b | t > 1              -- lifetime more than 1 month?
                    =  mortgage (p * (1+ir) - r) (t-1) ir r b

-- Example: computing monthly payment for a mortgage:
exPayment :: CFloat
exPayment = let r free in mortgage 100000 180 0.01 r 0 &> r

ex1 :: Float
ex1 = let r free in mortgage 100000 180 0.01 r 0 &> toFloat r

-- Compute time to amortize mortage (use ":set +first" here!):
ex2 :: Float
ex2 = let time free in mortgage 100000 time 0.01 1400 0 &> toFloat time


-- Testing:
testMG :: Prop
testMG = always $ abs (exPayment - 1200.168) < 0.01
