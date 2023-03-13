use [Handball_CH]

--b) two queries with the intersection operation; use INTERSECT and IN

SELECT * FROM PLAYER
SELECT * FROM CONTRACT 

-- Select Names from Contracts that are concluded(settled) with actual players (Contract: pid, Player: pid)
SELECT C.name
FROM Contract C
INTERSECT
SELECT P.name
FROM Player P

--(Alternative with IN)
-- All Contracts player names (pid) who are concluded with actual players (their pid appear on contract)
SELECT C.name
FROM Contract C
WHERE C.name IN (SELECT P.name FROM Player P)