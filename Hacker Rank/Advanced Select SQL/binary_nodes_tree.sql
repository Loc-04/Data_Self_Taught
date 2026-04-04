-- BST Table include 2 col are N and P (node and parent), a query to display which is what
--a root have no parent
--a leaf have parent
--a middle is the the rest of cases so we use else statement
--for display purpose, we must make it into 2 col, in this case understand the whole case when then end is a entire new col, simply take N and it

SELECT N, CASE WHEN P IS NULL THEN 'Root' WHEN N NOT IN (SELECT P FROM BST WHERE P IS NOT NULL) THEN 'Leaf' ELSE 'Inner'
END FROM BST ORDER BY N