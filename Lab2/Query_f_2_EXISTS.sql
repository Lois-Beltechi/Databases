use [Handball_CH]
--f) 2 queries with the EXISTS operator and a subquery in the WHERE clause

SELECT * FROM Coach 
SELECT * FROM Match
--Select all Coaches which are training less than 2 teams in order to help recruiters finding interim coaches for their team future matches,
--ordered ascendingly by their names
-- ARITHMETIC OPERATION in the Select clause
SELECT C.cid, C.no_of_teams_trained + 1 as NewTrainedTeams, C.coach_name
FROM Coach C
WHERE EXISTS
	(SELECT *
	FROM Match M
	WHERE M.mid=C.mid AND C.no_of_teams_trained<=1
	)
ORDER BY C.coach_name

-- Print players that have fans
select * from Player
select * from FanOfPlayer
select P.name
from Player P
where exists(
    select *
    from FanOfPlayer FP
    where FP.pid = P.pid
)