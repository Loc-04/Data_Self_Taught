--Euclidean distance formula : d(p,q)^2 = (q1-p1)^2 + (q2-p2)^2
--then use POWER to calculate squared value
--a,c is for p
--b,d is for q
SELECT CAST(ROUND(SQRT(POWER(MAX(LAT_N)-MIN(LAT_N), 2) + POWER(MAX(LONG_W)-MIN(LONG_W), 2)),4) AS DECIMAL (10,4)) FROM STATION;