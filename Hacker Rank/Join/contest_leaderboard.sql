--Create a CTE to find max score of each challenge belong to each hacker
--Main query join it, sum it up, having a condition > 0 to exclude hacker with 0 score

WITH maxx AS (
 SELECT hacker_id, challenge_id, MAX(score) AS max_score
FROM Submissions
GROUP BY hacker_id, challenge_id
)

SELECT x.hacker_id, H.name,  SUM(x.max_score) AS total
FROM maxx x
JOIN Hackers H ON x.hacker_id = H.hacker_id
GROUP BY x.hacker_id, H.name
HAVING SUM(max_score) > 0
ORDER BY total DESC, x.hacker_id;