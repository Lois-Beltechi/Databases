use [Handball_CH]
--i. 4 queries using ANY and ALL to introduce a subquery in the WHERE clause (2 queries per operator); 
--rewrite 2 of them with aggregation operators, and the other 2 with IN / [NOT] IN.

SELECT* FROM Player 

-- (##1) Print players better than all players in Russia (better relation given by the golden_globe_votes)
--used ALL x1, subquery in WHERE clause
SELECT P.name, P.golden_globe_votes
FROM Player P
WHERE P.golden_globe_votes > ALL(
	SELECT P2.golden_globe_votes
	from Player P2
	where P2.country='Russia'
)

-- (##2) Print players better than all players in Russia (better relation given by the golden_globe_votes) 
--used ALL x2, subquery in WHERE clause
--rewritten with an aggregation operator
--use MIN instead of ANY
SELECT P.name, P.golden_globe_votes
FROM Player P
WHERE P.golden_globe_votes > (
	SELECT max(P2.golden_globe_votes)
	from Player P2
	where P2.country='Russia'
)

-- Q3
-- (##3) Print players with fans 3 times younger than them
-- ANY #1; ARITHMETIC EXPRESSION
select * from Player
select * from Fan 
select * from FanOfPlayer 

select P.name --Arithmetic expression
from Player P
where P.age/3 > any(
	select F.age
	from Fan F 
	inner join FanOfPlayer FOP on FOP.fid = F.fid 
	inner join Player P2 on P2.pid = FOP.pid
	where P2.pid = P.pid
)

-- (##4)Print players with fans 3 times younger than them (aggregation operator)
select P.name --Arithmetic expression
from Player P
where P.age/3 > (
	select min(F.age)
	from Fan F 
	inner join FanOfPlayer FOP on FOP.fid = F.fid 
	inner join Player P2 on P2.pid = FOP.pid
	where P2.pid = P.pid
)

-- (##5) Print all the top 3 physicians with their info that have ever done a medical_test on a player
--used any
select* from Medical_Test 
select* from Physician -- physician x has done medical_test_id on someone

select top 3 P.*
from Physician P
where P.mid = any (
	select M.mid
	from Medical_test M
)ORDER BY P.name

-- (##6) Print all the top 3 physicians with their info that have done a medical_test on a player
--  ANY ---> IN
select top 3 P.*
from Physician P
where P.mid in (
	select M.mid
	from Medical_test M
)ORDER BY P.name

-- ##7 Find all Champinships that are not taking place in winter.
--using ALL
select * from Handball_Championship
Select H.*
from Handball_Championship H
WHERE H.season_id <> ALL(
	SELECT S.season_id
	FROM Season S
	WHERE S.season_type LIKE '%winter%'
)

-- ##8 Find all Championships that are not taking place in winter. (rewritten)
-- ALL -> NOT IN
--rewritten using NOT IN
Select H.*
from Handball_Championship H
WHERE H.season_id NOT IN(
	SELECT S.season_id
	FROM Season S
	WHERE S.season_type LIKE '%winter%'
)