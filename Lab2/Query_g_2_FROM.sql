use [Handball_CH]

--g. 2 queries with a subquery in the FROM clause;

SELECT * from Coach 
SELECT * from Player 
 
-- Print the coaches which have a salary of at least 6000 and are actually coaching a team/player (implicitly)... show the increased_salary and it's phone number
-- so that the manager can announce him
-- Their salary will increase with 1000 as a bonus for their improvement on player's general abilities, show those salaries ordered desc
--(arithmetic operation in the SELECT clause)
SELECT C.coach_name, C.coach_salary + 1000 AS increased_salary, c.coach_phone_number
FROM(
	SELECT *
	FROM Coach C
	WHERE NOT C.coach_salary< 6000 
	)c WHERE c.pid IN(
		SELECT DISTINCT P.pid
		FROM Player P
	)
	ORDER BY increased_salary DESC

SELECT* from Match
SELECT* from Training

-- Print all the matches (mid and the 2 teams) that are taking place in 31.11.22 date 
SELECT mtch.mid, mtch.opponents
FROM (
	SELECT* 
	FROM Match M
	WHERE M.date='31.11.22'
)mtch WHERE mtch.mid IN(
	SELECT T.mid
	FROM Training T
)