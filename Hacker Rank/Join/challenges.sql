--get hacker_id, name, and the total number of challenges created by each student.
--sort by total desc, hacker id
--but if same total,


--The solution will be separate in 2 parts, which is for better understanding

--Creating a CTE to take the highest total amount of chalenge by any hacker
WITH find_max AS(
SELECT TOP 1 COUNT(C.challenge_id) AS count_max
FROM Challenges C
JOIN Hackers H ON C.hacker_id = H.hacker_id
GROUP BY C.hacker_id
ORDER BY COUNT(C.challenge_id) DESC
)

--The main query will compare the amount of challenge of each hacker with CTE's value
SELECT H.hacker_id, H.name, COUNT(C.challenge_id)
FROM Hackers H
JOIN Challenges C ON H.hacker_id = C.hacker_id
GROUP BY H.hacker_id, H.name
--Use HAVING clause in order to kept any hacker who equal to the max value from CTE
HAVING COUNT(challenge_id) = (SELECT count_max FROM find_max)
--Use OR to handle the other case that if the count is lower and unique, it still kept, else, will be excluded
OR COUNT(challenge_id) IN (SELECT total_count
FROM (
    SELECT COUNT(challenge_id) AS total_count
    FROM Challenges
    GROUP BY hacker_id
) AS counts_table
GROUP BY total_count
HAVING COUNT(total_count) = 1)
ORDER BY COUNT(challenge_id) DESC, H.hacker_id;
