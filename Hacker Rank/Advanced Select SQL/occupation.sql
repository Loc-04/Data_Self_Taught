-- Pivot the `OCCUPATIONS` table to display an alphabetically sorted list of names for each profession, structured into exactly four columns in the following specific order: Doctor, Professor, Singer, and Actor. Ensure that the names within each column are sorted alphabetically from top to bottom, and if any occupation has fewer corresponding names than the maximum count across all professions, fill those empty grid spaces with `NULL` values.

-- **Output Format:** `Doctor_Name` | `Professor_Name` | `Singer_Name` | `Actor_Name`

--Step to solve are first using row num window function in order to point out the number of each row of value, which can consider the output is 1,2, etc
--Then group them by that rownum, using case when then for display again
--SInce hacker rank only allow to use 1 line of query at a time and the order of recognization of sql is won't help if i try to group by rownum now, so we must use CTE
--syntax used: case when then end,
with num_of_occu as(select Occupation,Name,row_number() over(partition by Occupation order by Name) as rownum from OCCUPATIONS) select max(case when Occupation = 'Doctor' then Name end), max(case when Occupation = 'Professor' then Name end), max(case when Occupation = 'Singer' then Name end),  max(case when Occupation = 'Actor' then Name end) from num_of_occu group by rownum;