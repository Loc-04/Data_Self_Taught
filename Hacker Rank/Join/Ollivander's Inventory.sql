--join 2 table first, then find where the wand is not evil
--then because we need to find the lowest price, we need a sub query to find the MIN
--but that have to be match with the code and power the outer found, because that's when we got the cheapest
--if not, the process continue


SELECT w.id, p.age, w.coins_needed, w.power
FROM Wands w
JOIN Wands_Property P ON w.code = p.code
WHERE p.is_evil = 0 AND w.coins_needed IN (SELECT MIN(w2.coins_needed)FROM Wands w2 WHERE w2.code = w.code AND w2.power = w.power)
ORDER BY w.power DESC, p.age DESC;