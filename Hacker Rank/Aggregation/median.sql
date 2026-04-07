--find a median number in the data set which often mistake as 'average' value

--there could be 2 way to solve this
--1st way : sort the col in a ascending way, the apply the median formula
-- check the number of row AKA n but in order to do this, must use count and give alias name
-- if odd, get the value at (n+1)/2 position
-- else calculate the value with (x(n/2) + x(n/2+1))/2



--2nd way : select the last value of the half top? Using rownum, then give the name for row num
-- then select top + that name, then take the last value by select top 1 value in descending way

--2ND WAY IS STUPID, use CEILING for round up, use FLOOR to round down, create a CTE to recall easier for calculation laater

WITH order_data AS(SELECT LAT_N, ROW_NUMBER() OVER (ORDER BY LAT_N) AS r, COUNT(LAT_N) OVER () AS n FROM STATION)SELECT CAST(LAT_N AS DECIMAL(10,4)) FROM order_data WHERE r IN (CEILING((n+1)/2), FLOOR((n+1)/2));
