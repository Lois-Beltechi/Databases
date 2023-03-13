-- use database da
USE [Handball_CH];
--Lab2

--INSERT
insert into Season VALUES(1,'Winter')
insert into Season VALUES(2,'Spring')
insert into Season VALUES(3,'Summmer')
insert into Season VALUES(4,'Autumn')
--SELECT * from Season

insert into Handball_Championship VALUES(1,1,'EHL Champions League')
insert into Handball_Championship VALUES(2,2,'World Handball Championship')
insert into Handball_Championship VALUES(3,3,'African Handball Championship') 
insert into Handball_Championship VALUES(4,4,'European Handball Championship')
insert into Handball_Championship VALUES(5,NULL,'Top 10 Teams Championship')
insert into Handball_Championship VALUES(6,1,'Winter Handball Special')
--SELECT * from Handball_Championship

insert into Team VALUES(1,'CSM BUCURESTI','Romania') 
insert into Team VALUES(2,'U CLUJ','Romania')
insert into Team VALUES(3,'CS RAPID BUCURESETI', 'Romania')
insert into Team VALUES(4,'CS MINAUR BAIA MARE','Bulgary')
insert into Team VALUES(5,'ROMANIA', NULL)
insert into Team VALUES(7,'Sweden', NULL)


--SELECT * from Team

insert into Match VALUES(1,'27.12.22', 'U CLUJ - CSM BUCURESTI', 'BUCURESTI')
insert into Match VALUES(2,'31.11.22', 'U CLUJ - CS MINAUR BAIA MARE', 'BAIA MARE')
insert into Match VALUES(3,'31.11.23', 'CS RAPID BUCURESTI - CSM BUCURESTI', 'ORADEA')
insert into Match VALUES(4,'31.11.22', 'CS RAPID BUCURESTI - CS MINAUR BAIA MARE', 'BUCURESTI')
--SELECT * from Match
														 --votes, age
insert into Player VALUES(1,'Dana',163, 76, 'Pivot','Romania',98, 57)
insert into Player VALUES(2,'Angela', 170,77, 'Extrema Stanga','France',83,77)
insert into Player VALUES(3,'Andreea', 166,71, 'Extrema Dreapta','Russia',79,29)
insert into Player VALUES(4,'Alexandra', 183,90, 'Portar','Russia',80,19) 
insert into Player VALUES(5,'Crina', 166,92, 'Pivot','Brazil',81,51) 
insert into Player VALUES(6,'Olimpia', 160,75, 'Portar','Germany',60,null) 
insert into Player VALUES(7,'Claudia', 190,90, 'Pivot','Sweden',55,null) 
insert into Player VALUES(8,'Marta', 195,100, 'Pivot','Hungary',95,null) 
insert into Player VALUES(9,'Marta', 195,103, 'Pivot','Bulgary',96,null) 
insert into Player VALUES(10,'Marta', 198,104, 'Pivot','Portugal',81,null) 


--SELECT * from Player

					--c match pl  --name          nr_tel   -kg   --salar
insert into Coach VALUES(1,1,2,'Edi Iordanescu', '0743591542', 77, 5000, 1)
insert into Coach VALUES(2,3,4,'Teodora Vasilescu', '0743591250', 78, 6200,2)
insert into Coach VALUES(3,NULL,NULL,'Popescu Zamfir', '0743591253', 71, NULL, 0)

insert into Coach VALUES(4,NULL,NULL,'Todoran Marioara', '0743591256', 76, NULL,0)
insert into Coach VALUES(5,3,5,'Bogdan Burcea', '0743591258', 80, 6250,2)
--insert into Coach VALUES(6,3,4,'Teodora Vasilescu', '0743591250', 78, 6200,2)
--SELECT * from Coach
                           --c p
insert into Contract VALUES(1,2,'Angela','31.11.22', 25000)
insert into Contract VALUES(4,6,'Olimpia','26.11.22', 25200) ---%%
insert into Contract VALUES(2,1,'Dana','30.11.22', 21000)
insert into Contract VALUES(5,4,'Alexandra','27.11.22', 23000)
insert into Contract VALUES(3,5,'Crina','25.11.22', 23000)
--SELECT * from Contract

insert into Medical_test VALUES(1, 'Dana', 76,'Heart and health')
insert into Medical_test VALUES(2, 'Angela', 77,'Musculoskeletal stability ')
insert into Medical_test VALUES(3, 'Andreea', 49,'Isokinetic')  
insert into Medical_test VALUES(4, 'Catalina', 55,'Body fat score')  
insert into Medical_test VALUES(5, 'Daria', 45,'Ergometric sprint test')  
insert into Medical_test VALUES(6, 'Teodora', 54,'Isokinetic')  
--SELECT * from Medical_test

                         --pid mid 
insert into Physician VALUES(1, 1, 'Dr. D',52, 'Cardiology',6200)
insert into Physician VALUES(2, 2, 'Dr. A',88, 'Neuro',10000)
insert into Physician VALUES(3, 3, 'Dr. B',77,'Psychiatry',8900)
insert into Physician VALUES(4, 4, 'Dr. K',90,'Cardiology',7000)
insert into Physician VALUES(5, 5, 'Dr. R',100,'Gastroenterology',7600)
insert into Physician VALUES(6, 6, 'Dr. G',65,'Nutrition and Dietetics',7777)
insert into Physician VALUES(7, NULL, 'Dr. Q',69,NULL,NULL)
--SELECT * from Physician 

						--tid  matchid
insert into Training VALUES(5,2,'31.11.22', 'Stadionul CSM BUC','Plyometric training')
insert into Training VALUES(6,3, '1.11.22', 'Stadionul Baia Mare','Strength training')
insert into Training VALUES(7,4, '31.11.22', 'Stadionul CS RAPID BUCURESTI','Drop jumps training')
--SELECT * from Training
                      --pid training id
insert into Goes_To VALUES(1,5, 'attacking')
insert into Goes_To VALUES(2,6, 'defending')
--SELECT * from Goes_To
								    --sid mid
insert into Special_Guests_Veterans VALUES(1,3, 'Da Silva', 'Inter','AC Milan', 23)
insert into Special_Guests_Veterans VALUES(2,2, 'Neyira', 'Central','Real Madrid',13)
insert into Special_Guests_Veterans VALUES(3,3, 'Neagu', 'Central','Gyor',8)
insert into Special_Guests_Veterans VALUES(4,3, 'Rodriguez', 'Central','Barcelona',17)
insert into Special_Guests_Veterans VALUES(5,3, 'Abbingh', 'Inter','Odense',10)
--SELECT * from Special_Guests_Veterans

						 --hid -teamid
insert into Participate VALUES(1,1, '31.10.22', 'CSM BUCURESTI')
insert into Participate VALUES(2,3, '27.12.22', 'CS RAPID BUCURESETI')
insert into Participate VALUES(4,2, '31.11.23', 'U CLUJ')
insert into Participate VALUES(1,4, '31.10.22', 'CS MINAUR BAIA MARE')

--SELECT * from Participate

			    --coachid teamid
insert into Have VALUES(1,2, 'offensive')
insert into Have VALUES(2,5, 'defending')
insert into Have VALUES(2,4, 'balanced')
insert into Have VALUES(5,3, 'offensive')
insert into Have VALUES(5,7, 'offensive')--------------


--insert into Have VALUES(NULL,3, 'offensive')
--SELECT * from Have


insert into Fan values (1, 'Jack', 21, 'Romania')
insert into Fan values (3, 'Flaviu', 19, 'Russia')
insert into Fan values (2, 'Charles', 24, 'UK')
insert into Fan values (4, 'Johnny', 33, 'USA')
insert into Fan values (5, 'Alexandru', 37, 'China')


							--fid  pid, fan_percen
insert into FanOfPlayer values (1, 3,90)
insert into FanOfPlayer values (3, 2,40)
insert into FanOfPlayer values (2, 2,97)
insert into FanOfPlayer values (4, 2,77)
--insert into FanOfPlayer values (5, 11) --...error, no matching player_id for this FanOfPlayer


--UPDATE STATEMENTS


--#1
--used =
Select * From Coach -- original table
--update the salary of the coach with the Coach cid=2 to 6300
UPDATE Coach SET coach_salary=6300 WHERE cid=2 
Select * From Coach -- updated table


--#2
-- used AND,IN,BETWEEN
SELECT* FROM Fan --original table
----update the age of the fans from USA and UK that have an age between 25 and 35 years old
UPDATE Fan SET age=age+1 WHERE country IN ('USA', 'UK') AND age BETWEEN 25 AND 35 
SELECT* FROM Fan --updated table


--#3
--used IS NULL
SELECT * FROM Player -- original table
--update the age of a player that has age written as null (set their age to 18 because they are from junior teams recently joining a senior team)
UPDATE Player SET age=18 WHERE age is NULL 
SELECT * FROM Player -- modified table
----
UPDATE Player SET age=NULL WHERE age=18
SELECT * FROM Player


--DELETE STATEMENTS

insert into Team VALUES(6,'HUNGARY', NULL)
select * from Team -- original table
--#1 
--used LIKE
--Delete from Team teams that contain the country 'Hungary' in theem
DELETE FROM Team
WHERE team_name LIKE '%Hungary%'

select * from Team -- modified table



insert into Fan VALUES(10,'Cadmiel',101,'Romania')

select * from Fan -- original table
--#2
--used >
--delete the fans that are older than 100 years
DELETE FROM Fan 
WHERE age > 100

select * from Fan -- modified table

