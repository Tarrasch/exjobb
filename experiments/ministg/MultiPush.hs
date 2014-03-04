-- Testar ifall jag kan få en (* a1 a2 a3) på stacken
--
-- Poängen är att jag vill se att det kan blir flera argument givna till en
-- funktion och inte bara en åt gången, som det är med update frames.


test x y z =
    f 5 10
  where
    f = if (x - y) > z then (+) else (-)
