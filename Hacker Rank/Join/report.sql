--descending order by grade
--grade 8-10 student order by name
--grade < 8  replace name with NULL and order by grade descending
--Solution is doing a JOIN non-equi, which doesn't require a specific col to match
--Use compare operator to solve such as between
--The question is about checking if the student grade is in the range from min to max grade

SELECT CASE WHEN G.Grade <8 THEN 'NULL' ELSE S.Name END,G.Grade, S.Marks FROM Students S, Grades G WHERE S.Marks BETWEEN G.Min_Mark AND G.Max_Mark ORDER BY G.Grade DESC, S.Name ;
