--write a query calculate the amount of error, round it up to the next integer
--Table : EMPLOYEES : ID, Salary (Int), Name (string)
--Constraints: 1000 < Salary < 10^5
--Using REPLACE() function to solve the number without 0 logic, but have to use CAST to force it from string to numeric
--But the output must be round up, which technically mean it's value have to be decimal or float
--But in this case multiplying the number with 1.0 BEFORE DOING ANY CALCULATION is a better approach
--Then finally use CEILING() to round up

SELECT CEILING(AVG(Salary*1.0) - AVG(CAST(REPLACE(Salary,'0', '')AS INT)*1.0)) FROM EMPLOYEES;