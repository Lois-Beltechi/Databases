use [Handball_CH]

--h. 4 queries with the GROUP BY clause, 
--3 of which also contain the HAVING clause; 2 of the latter will also have a subquery in the HAVING clause; 
--use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;

-- && S1. Print per each Veteran's former position the average of the titles earned during the career. We want to see which player_position
--was the best in that period.
--used AVG
SELECT* from Special_Guests_Veterans
SELECT S.player_position,  AVG(Cast(S.no_of_titles_earned_during_career as Float)) as avg_titles_earned
FROM Special_Guests_Veterans S
GROUP BY S.player_position

-- &&& S2. Print player positions with at least 2 players per that particular position 
SELECT * FROM Player
SELECT P.position, count(*) as no_of_player_position
FROM Player P
GROUP BY P.position
having count(*) >= 2

--SELECT* from  Coach
--SELECT* from  Player
--SELECT* from  Contract 

SELECT* from  Coach
SELECT* from  Player
SELECT* from  Contract 

-- &&& S3. How many players have the same salary on their contract? Print only the maximum frequency of those salaries along with their salary!  
SELECT C.remuneration,COUNT(*) as frequency_of_this_remuneration
FROM Contract C
	INNER JOIN Player P on P.pid=C.pid
	INNER JOIN Coach CH on CH.pid=P.pid
	GROUP BY  C.remuneration
	HAVING COUNT(*)=(
		select MAX(t.C)
		from (select count(*) C
			FROM Contract C
			INNER JOIN Player P on P.pid=C.pid
			INNER JOIN Coach CH on CH.pid=P.pid
			GROUP BY C.remuneration
			)t
	)

SELECT * FROM Player

-- $$$ S4. Print the position that got in total the minimum number of votes at Best Player Of the Season [Golden Globe votes] (votes per Player position)
--contains the HAVING clause
--has a subquery in the HAVING clause
--used SUM, MIN
SELECT P.position, SUM(P.golden_globe_votes) AS total_votes
FROM Player P
GROUP BY P.position 
HAVING SUM(P.golden_globe_votes) = (
	SELECT MIN (T.s)
	FROM(
		SELECT SUM(P2.golden_globe_votes) as s
		FROM Player P2
		GROUP BY P2.position
	)as T
)