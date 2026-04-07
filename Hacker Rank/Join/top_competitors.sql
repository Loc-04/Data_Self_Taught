--get name and id of the hacker who full score > 1 challenge, order desc by total num of challenge full score, if more than 1, sort by id
--join all 4 tables, need to compare score between max score for each difficulty and score in submissions
--then count the challenge id to see who pass the >1 challenge requirement
--WHERE can't handle aggregate function like COUNT, so we need to use HAVING, which is WHERE but for functions

SELECT H.hacker_id, H.name
FROM Hackers H
JOIN Submissions S ON H.hacker_id = S.hacker_id
JOIN Challenges C ON S.challenge_id = C.challenge_id
JOIN Difficulty D ON C.difficulty_level = D.difficulty_level
WHERE C.difficulty_level = D.difficulty_level AND D.score = S.score
GROUP BY H.hacker_id, H.name
HAVING COUNT(S.challenge_id) >1
ORDER BY COUNT(S.challenge_id) DESC, H.hacker_id;
