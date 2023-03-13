drop table Evaluate
drop table Judges
drop table Poems
drop table Competitions
drop table Awards
drop table Users
create table Users(
	userID int primary key,
	name varchar(20),
	penName varchar(20) unique,
	yob int
)

create table Awards(
	awardID int primary key,
	userId int references Users(UserID),
	name varchar(30)
)

create table Competitions(
	competitionID int primary key,
	Yearr int,
	Weekk int
)


create table Poems(
	poemID int primary key,
	userID int references Users(userID),
	competitionID int references Competitions(competitionID),
	title varchar(20),
	text varchar(100)
)

create table Judges(
	judgeID int primary key,
	name varchar(20)
)

create table Evaluate(
	poemID  int references Poems(poemID),
	judgeID int references Judges(judgeID),
	points int,
	primary key (poemID,judgeID)
)

INSERT INTO Users  VALUES(1,'Ana', 'Pen1',2001),(2,'Maria', 'Pen2',2002),(3,'George', 'Pen3',2003)
INSERT INTO  Awards VALUES (1,1 ,'Cel mai bun poem'),(2,2, 'Cel mai frumos poem')
INSERT INTO Competitions  VALUES (1,2020,1),(2,2021,2)
INSERT INTO  Poems  VALUES (1,1,1,'Sara pe deal','cnjsndciswn'),(2,1,1,'Lacul','dixsdisd'),(3,2,1,'Stele','xnsaini'),(4,2,2,'Nuferi','dicdsid'),(5,3,1,'Flori','xdwn')
INSERT INTO Judges  VALUES(1,'Mihai Petre'),(2,'Elvira Petre')
INSERT INTO Evaluate  VALUES (1,1,5),(1,2,3),(2,1,3),(2,2,5),(3,1,1),(3,2,1),   (4,1,1),(4,2,2)

Delete from Evaluate
Delete from Judges
Delete from Poems
Delete from Competitions
Delete from Awards
Delete from Users


select * from Users
select * from Awards
select * from Competitions
select * from Poems
select * from Judges
select * from Evaluate


--b)
GO
CREATE PROCEDURE DeleteJudgeAndEvaluations(@JudgeID INT)
AS
	IF @JudgeID IS NULL
	BEGIN
		RAISERROR('No such judge', 16, 1)
		RETURN -1
	END;
	
	DELETE FROM Evaluate
	WHERE @JudgeID=judgeID

	DELETE FROM Judges
	WHERE @JudgeID=judgeID

GO
EXEC DeleteJudgeAndEvaluations 1


--c)
GO
create or alter view ShowPoems
AS
	SELECT Yearr, Weekk  
	FROM Competitions
	WHERE competitionID in
		(SELECT competitionID --,AVG(points ) as averagePoints
				FROM Poems p INNER JOIN Evaluate e ON e.poemID=p.poemID
				Group by competitionID
				Having count(*)>3 and avg(points)<5
		)
	
GO

SELECT * FROM ShowPoems

--d)
GO
create or alter function UserThatSubmittedPoems(@mai_mare_ca INT)
	returns table
	return

	SELECT name, penName FROM Users
	WHERE userID IN (
		SELECT userID
		FROM Poems
		GROUP BY userID
		HAVING Count(*) > @mai_mare_ca
	)
	
GO


SELECT * FROM  UserThatSubmittedPoems(1)




