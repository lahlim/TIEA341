L4_Q2_2018_2
In which languages is it possible for a polymorphic funtion to branch according to the type of the input expression?

Mark these either as True or False:
Java: public static int Foo<T>(T x) {...} - True

C#: static int Foo<T>(T x) {...} - True

Haskell: f :: t -> Int; f = ... - True

python: def f: ... - True


- kaikissa ylläolevissa kielissä voidaan jättää tyyppi avoimeksi
------------------------------------------------------------
L4_Q5_2018_2
Based on what you know about polytypes, can you write a Haskell expression with the type forall a. a -> a?

Mark these either as True or False:
Ei voi - False

Kyllä voi, mutta sitä lauseketta ei voi laskea - True

Kyllä voi ja voi myös laskea! - False

Eri operaattoreilla on eri merkitykset tietotyypistä riippuen, esim a+1 ei onnistu.

------------------------------------------------------------
L4_Q6_2018_2
If I have function f :: forall a. a -> a it can be:

Mark these either as True or False:
Stall or crash the program - True

It can be a constant function, ie. function that always returns the same value - False

It can be the identity function: \x->x -True

It can change it's input in almost any imaginable way - True? syöte voi muuttua muttei funktio itsessään voi muuttaa syötettä

Funktio voi käytännössä palauttaa itsensä tai sitten aiheuttaa virheilmoituksen jos yritetään käyttää operaattoreita

-------------------------------------------------------------

L4_Q8_2018_2
If we know that f :: forall a. [a] -> Maybe a, but we don't know how f is implemented, what can we deduce from the following test

f "foobar" = Just 'f'
Mark these either as True or False:
f [1,2,3,4,5,6] == Just 1 - True

f [True,False,True,False,True,False] == Just True - True

f always returns the first element of the input list - False

f [] == Nothing or computation of f crashes/never terminates - True

f [1] == Just 1 - True

Maybe voi palauttaa nothingin, tai jonkin alkion annetusta listasta.





IL 3

L3_Q1_2018_1
Let's review how function application is typed. Given that

f :: Int -> Bool -> String
x :: Int
what is f x

Mark these either as True or False:
String - False

Bool -> String - True

Int -> Bool -> String - False

(Int -> Bool -> String) Int - False

Testattu GHCI:ssä

-------------------------------------------------------------------------------

L3_Q2_2018_1
Suppose that even :: Int -> Bool. What then, is the type of

\x -> even (x+1)
Mark these either as True or False:
Int - False

Bool - False

Int -> Bool - True

Int -> Int -> Bool - False

funktion kuvaus itsessään kertoo jo tyypin, testattu myös ghci:ssä

-------------------------------------------------------------------------------

L3_Q3_2018_1
Which are proper specializations of forall a b. (a -> b -> a) -> b -> [a] -> b?

Mark these either as True or False:
(Int -> Int -> Int) -> Int -> [Int] -> Int - False

(Int -> Bool -> Int) -> Bool -> [Int] -> Bool - True

(Int -> Bool -> Int) -> Bool -> Int -> Bool - False

(Int -> Bool -> Int) -> Int -> Bool -> Int - False

Toinen on ainoa joka vastaa kuvausta, muista puuttuu joko taulukko tai kuten ensimmäisessä,
a ja b eivät ole eri tyyppisiä

-------------------------------------------------------------------------------

L3_Q4_2018_1
Why does fun work and sad doesn't?

fun :: [Double]
fun = let x = 3 in take x (repeat x)
sad :: [Double]
sad = (\x -> take x (repeat x)) 3
-- take :: Int -> [a] -> [a]
-- repeat :: a -> [a]

Mark these either as True or False:
The function sad has a type error (type should be a function) - True

Function argument cannot have a forall a. type, but let-bound variable can - False

Function argument can have a forall a. type, but let-bound variable can't - False

-------------------------------------------------------------------------------

L3_Q5_2018_1
Based on what you know about polytypes, can you write a Haskell expression with the type forall a. a?

Mark these either as True or False:
Ei voi - True

Kyllä voi, mutta sitä lauseketta ei voi laskea - False

Kyllä voi ja voi myös laskea! - False

Pisteen jälkeen pitäisi olla eri muuttuja kuin ennen pistettä

-------------------------------------------------------------------------------

L3_Q6_2018_1
Which of the types below can be given a proper implementation? (ie. aside from error, infinite recursion, etc.)

Mark these either as True or False:
f :: forall a. Bool -> a True

g :: forall a. a -> Bool - True

h :: forall a b. (b -> a) -> a - True

j :: forall a b. b -> (a -> b) - False

-------------------------------------------------------------------------------

L3_Q7_2018_1
Why is it possible to implement forall a. a -> Bool but not forall a. Bool -> a?

Mark these either as True or False:
Because you can always make a function that returns True for all inputs - True

Because you can always check if the argument (of type a) is null and return True/False based on that - False

Function can return True if it is given an argument and False otherwise - False

Anything can be converted to a Bool. E.g., 1=True and 0=False - True

Ei varmaa tietoa, ensimmäinen ja viimeinen vaikuttivat todennäköisimmiltä

-------------------------------------------------------------------------------

L3_Q8_2018_1
We know that function with type forall a. a -> a is always an identity function. How about if the term a->a appears inside a bigger type? Must the corresponding argument/result be an identity function in the types below?

Mark these either as True or False:
(\ f xs -> ...) :: forall a. (a->a) -> [a] -> [a] - True

(\xs -> \x -> ...) :: forall a. [a] -> (a->a) - True

(\xs -> \y -> ...) :: forall a b. [b] -> (a->a) - False

(\xs -> \ f -> ...) ::forall a. [a] -> (a->a) -> [a] - False

