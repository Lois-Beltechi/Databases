
use [Handball_CH]

----join at least two many-to-many relationships
--FULL JOIN

SELECT * from Coach
SELECT * from Have
SELECT * from Team
SELECT * from Participate
SELECT * from Handball_Championship

-- Print All Coaches that either don't have a team to train, 
--or all coaches that have a team but that team is not included to any Handball Championship,
--or print all teams that are qualified for a Handball Championship but don't have a coach, 
--or print all the Handball_Championships that don't have any team participating to its own championship

--Filter out Coaches that have a team that is included/qualified in a Handball Championship 

SELECT C.coach_name, T.team_name,H.championship_name
FROM Coach C
FULL JOIN Have Hve ON Hve.cid=C.cid
FULL JOIN Team T ON T.tid=Hve.tid
FULl JOIN Participate P ON P.tid=T.tid
FULL JOIN Handball_Championship H ON H.hid=P.hid
where C.coach_name is null or T.team_name is null or H.championship_name is null
