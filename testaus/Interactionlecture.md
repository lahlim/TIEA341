# 1

product [] = 0 -- 1.
product (x:xs) = x \* product xs -- 2.

What does product [1,2,3] evaluate to?

Nolla on ainut true, sillä lista alkiot kerrotaan nollalla.

# 2

Oikeat:

- if x then "Good" else "Bad"
- if x == True then "Good" else "Bad"

Väärät:

- if x else "Bad"

- if x then "Good"

Tarvitaan if then ja else. Haskelissa ei toimi pelkkä iffin käyttö kuten muissa perinteisimmissä ohjelmointi kielissä. Lisäksi tarvitaan then, joka ilmaisee mitä palautetaan jos eh to toteutuu ja viimeisenä tarvitaan else, jos ehto ei ole tosi. Haskelissa funktio siis aina palauttaa jotain.

# 3

En ole varma ymmärränkö lysymystä, mutta lopputulos on Hello, Jimmy.
x3 = Jimmy ja se menee greeting funktiolle parametrinä.

# 4

Left False
Right True

# 5

    - ((map f) x):xs TRUE

    - (map f) x:xs TRUE

    - map f (x:xs) FALSE

    - map f x:xs FALSE

Operaatio on vasemmalle assosiatiivinen, joten kaksi ensimmäistä sulutusta on oikein tässä tehtävässä.

# 6

atan2 pi/12 pi2.1

    Function application (f x) FALSE

    Division (E₁ / E₂) FALSE

    Multiplication (E₁ * E₂) FALSE

    Syntax error TRUE

Todennäköisesti tulee syntax error tehtävä on vaativa ja itsellä loppuu tulkinta kyky kesken. Lisäksi hieman vaikeasti ymmärrettävä kysymys.
