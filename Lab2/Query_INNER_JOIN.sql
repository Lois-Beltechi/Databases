use [Handball_CH]
---d) 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN and FULL JOIN (one query per operator); one query will join at least 3 tables, while another one will join at least two m:n relationships
--INNER JOIN

SELECT * FROM Medical_test
SELECT * FROM Physician 

--Get for each Physician the medical test they had done on players by selecting each Physician's name & Medical_test's type of procedure

-- Print what type of medical test each Physician made
SELECT M.type_of_medical_test, P.name as Physician_in_Charge
FROM Medical_test M INNER JOIN Physician P on M.mid=P.mid