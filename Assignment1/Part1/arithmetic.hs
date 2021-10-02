-- A Virtual Machine (VM) for Arithmetic (template)

-----------------------
-- Data types of the VM
-----------------------

--nn_int :: Integer -> NN
--int_nn :: NN->Integer
--ii_int :: Integer -> II
--int_ii :: II -> Integer
--pp_int :: Integer -> PP
--int_pp :: PP->Integer


--float_qq :: QQ -> Float --truncating float to int
--float_qq :: QQ (n m) = fromInteger(int_ii(n))/fromInteger(int_pp(m))



-- Natural numbers
data NN = O | S NN
  deriving (Eq,Show) -- for equality and printing

-- Integers
data II = II NN NN
  deriving (Eq,Show) -- for equality and printing

-- Positive integers (to avoid dividing by 0)
data PP = I | T PP
  deriving(Eq, Show)

-- Rational numbers
data QQ =  QQ II PP --type QQ requires II numerator and PP denominator

------------------------
-- Arithmetic on the  VM
------------------------

----------------
-- NN Arithmetic
----------------

-- add natural numbers
addN :: NN -> NN -> NN
addN O m = m
addN (S n) m = S (addN n m)


-- multiply natural numbers
multN :: NN -> NN -> NN
multN O m = O
multN (S n) m = addN (multN n m) m


-- subtract natural numbers
subN :: NN -> NN -> NN
subN O m = O
subN m O = m
subN (S n) (S m) = subN n m


----------------
-- II Arithmetic (II is natural number natural number) with declarer
-- -- Addition: (ac)-(bd)=
----------------
addI :: II -> II -> II
addI (II a b) (II c d) = II (addN a c) (addN b d)

--multI :: II -> II -> II
--multI (II a b) (II c d) = II (addN (multN a c) (multN b d)) (II addN (multN a d) (b c))

-- II Subtraction (a-b)-(c-d)=(a+d)-(b+c)
--subtrI :: II -> II -> II
--subtrI (a b) (c d) = subN

----------------
-- QQ Arithmetic
----------------

-- add positive numbers
--addP :: PP -> PP -> PP
--addP I m = T m
--addP (T p) I = T (addP p I)

-- multiply positive numbers
-- multP :: PP -> PP -> PP
-- T and I but T is successor and I is one
-- I m = m


-- convert numbers of type PP to numbers of type II
--ii_pp :: PP -> II

-- Addition: (a/b)+(c/d)=(ad+bc)/(bd)
--addQ :: QQ -> QQ -> QQ
--addQ (QQ a b) (QQ c d) = QQ(addI(multI(a)ii_pp(d))) (multI(ii_pp(b))(c)) (multP(b)(d))

-- Multiplication: (a/b)*(c/d)=(ac)/(bd)
--multQ :: QQ -> QQ -> QQ
--multQ (QQ a b) (QQ c d)= QQ(multP(a)(c)) (multP(b)(d))
--multQ :: (QQ a b) (QQ c d)= QQ(multI(ii_pp(a))(c)) (multImultI(ii_pp(b))(d))

addP :: PP -> PP -> PP
addP I m = (T m)
addP (T n) m = T (addP n m)


--addition (a/b)+(c/d)=(ad+bc)/(bd)
--addQ ::QQ->QQ->QQ
--addQ :: (QQ a b) (QQ c d) = QQ(addI(multI(a)ii_pp(d))) (multI(ii_pp(b))(c)) (multP(b)(d))
--addI(MultI(a)(ii_pp(d))(ii_pp(b))(c)) (multI(ii_pp(b))ii_p(d))



----------------
-- Normalization
----------------
--add(S n) m = S (add n m)
--   n=x-1 y         x-1

--normalizeI :: II -> II
--II (S(S O)) (S O)
--II (S O ) O

----------------------------------------------------
-- Converting between VM-numbers and Haskell-numbers
----------------------------------------------------

--convert number of type PP to type II (PP is a recursive data type)
--ii_pp I = II(S O) O --how to get started
--ii_pp(T n)= addI (S O) n-- how to do +1 of integers? ... ii_pp ... n (needs to be on right side again because recursion)
--ii_pp :: pp-> II


----------
-- Testing
----------
main = do
    print $ addN (S (S O)) (S O)
    --print $
    print $ subN (S(S (S O))) (S O)
    print $ multN (S (S O)) (S (S (S O)))
    print $ addP (T I) (T I)
    print $ addP (T (T I)) (T I)
    print $ addP (T (T I)) (T (T (T I)))

    print $ addI (II (S (S O)) (S O))  (II (S (S (S O))) (S (S O)))




    --multP O m = O
    --multP (S n) m = addN (multN n m) m
