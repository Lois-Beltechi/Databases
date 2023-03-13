use [Handball_CH]

--e) 2 queries with the IN operator and a subquery in the WHERE clause; in at least one case, the subquery should include a subquery in its own WHERE clause

SELECT * FROM Coach
SELECT * FROM Player 
SELECT * FROM Contract 
	--Select Coaches name and their pid that are training players with a contract remuneration under 24.000
	--used distinct
	SELECT C.coach_name, C.pid
	FROM Coach C
	WHERE C.pid IN
		(SELECT distinct P.pid
		FROM Player P
		WHERE P.pid IN
		(SELECT Ctc.pid
		FROM Contract Ctc 
		WHERE Ctc.remuneration<=24000)) 

SELECT* FROM Physician
SELECT* FROM Medical_test

--Select the top 3 Physicians_name with a pacient having kg less than 60 and increase  / multiply their salary by 2 due to their pacient possible
-- future interventions, order by the incresed salary ASC

SELECT TOP 3 P.name, P.remuneration*2 as IncreasedSalary
FROM Physician as P
WHERE P.mid IN
	(SELECT M.mid
	FROM Medical_test M
	WHERE M.kg<=60
	)
ORDER BY IncreasedSalary ASC