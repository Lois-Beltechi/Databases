DROP TABLE list;
DROP TABLE cinema_production;
DROP TABLE movie;
DROP TABLE stage_director;
DROP TABLE company;
DROP TABLE actor;

INSERT INTO company (companyID, name) VALUES
  (1, 'Acme Corporation'),
  (2, 'XYZ Studios'),
  (3, 'ABC Productions'),
  (4, 'Def Pictures'),
  (5, 'MNO Films');

INSERT INTO stage_director (directorID, name, awards) VALUES
  (1, 'John Smith', 'Academy Award for Best Director'),
  (2, 'Jane Doe', 'Golden Globe for Best Director'),
  (3, 'Bob Johnson', 'BAFTA Award for Best Director'),
  (4, 'Alice Smith', 'Critics Choice Award for Best Director'),
  (5, 'William Thompson', 'Gotham Award for Best Director');

INSERT INTO movie (movieID, name, date, companyID, directorID) VALUES
  (1, 'Movie 1', '2022-01-01', 1, 1),
  (2, 'Movie 2', '2022-02-01', 2, 2),
  (3, 'Movie 3', '2022-03-01', 3, 3),
  (4, 'Movie 4', '2022-04-01', 4, 4),
  (5, 'Movie 5', '2022-05-01', 5, 5);

INSERT INTO cinema_production (productionID, title, movieID) VALUES
  (1, 'Cinema Production 1', 1),
  (2, 'Cinema Production 2', 2),
  (3, 'Cinema Production 3', 3),
  (4, 'Cinema Production 4', 4),
  (5, 'Cinema Production 5', 5),
  (6, 'Cinema Production 6', 1),
  (7, 'Cinema Production 7', 1)
INSERT INTO actor (actorID, name, ranking) VALUES
  (1, 'Tom Hanks', 1),
  (2, 'Meryl Streep', 2),
  (3, 'Denzel Washington', 3),
  (4, 'Sandra Bullock', 4),
  (5, 'Leonardo DiCaprio', 5);

INSERT INTO list (productionID, actorID, entryMoment) VALUES
  (1, 1, '2022-01-01 12:00:00'),
  (1, 2, '2022-01-01 12:00:01'),
  (1, 3, '2022-01-01 12:00:02'),
  (1, 4, '2022-01-01 12:00:03'),
  (1, 5, '2022-01-01 12:00:04'),
  (2, 1, '2022-02-01 12:00:00'),
  (2, 2, '2022-02-01 12:00:01'),
  (2, 3, '2022-02-01 12:00:02'),
  (2, 4, '2022-02-01 12:00:03'),
  (2, 5, '2022-02-01 12:00:04'),
  (3, 1, '2022-03-01 12:07:00'),
  (4, 1, '2022-03-01 12:07:00'),
  (5, 1, '2022-03-01 12:07:00')

DELETE FROM list;
DELETE FROM actor;
DELETE FROM cinema_production;
DELETE FROM movie;
DELETE FROM stage_director;
DELETE FROM company;





CREATE TABLE company (
  companyID INTEGER PRIMARY KEY,
  name TEXT
);

CREATE TABLE stage_director (
  directorID INTEGER PRIMARY KEY,
  name TEXT,
  awards TEXT
);

CREATE TABLE movie (
  movieID INTEGER PRIMARY KEY,
  name TEXT,
  date DATE,
  companyID INTEGER,
  directorID INTEGER,
  FOREIGN KEY (companyID) REFERENCES company (companyID),
  FOREIGN KEY (directorID) REFERENCES stage_director (directorID)
);

CREATE TABLE cinema_production (
  productionID INTEGER PRIMARY KEY,
  title TEXT,
  movieID INTEGER,
  FOREIGN KEY (movieID) REFERENCES movie (movieID)
);

CREATE TABLE actor (
  actorID INTEGER PRIMARY KEY,
  name TEXT,
  ranking INTEGER
);

CREATE TABLE list (
  productionID INTEGER,
  actorID INTEGER,
  entryMoment DATETIME,
  PRIMARY KEY (productionID, actorID),
  FOREIGN KEY (productionID) REFERENCES cinema_production (productionID),
  FOREIGN KEY (actorID) REFERENCES actor (actorID)
);

 SELECT * FROM company;
SELECT * FROM stage_director;
SELECT * FROM movie;
SELECT * FROM cinema_production;
SELECT * FROM actor;
SELECT * FROM list;


--b)
GO
CREATE or alter PROCEDURE addRecordToList (@productionID INT, @actorID INT, @entryMoment datetime)
AS
	IF @actorID NOT in (SELECT actorID From actor)
	BEGIN
		RAISERROR('No such actor', 16, 1)
		RETURN -1
	END;

	IF @productionID NOT in (SELECT productionID From cinema_production)
	BEGIN
		RAISERROR('No such presentation production', 16, 1)
		RETURN -1
	END;

	IF exists (SELECT * From  list where @productionID=productionID and @actorID=actorID)
	BEGIN
		RAISERROR('Records already in the table', 16, 1)
		RETURN -1
	END;

	INSERT INTO list VALUES (@productionID,@actorID,@entryMoment)
GO

exec addRecordToList 3,3,'2022-03-01 12:01:00'

--c)
GO
create or alter view allActorsInAllProductions
AS
	SELECT name from actor a
	WHERE 
	NOT EXISTS
    (SELECT productionID  FROM cinema_production -- n-o sa fie niciuna la card1
    EXCEPT
    SELECT productionID FROM list l
    WHERE l.actorID=a.actorID
	)
GO

SELECT * FROM allActorsInAllProductions

--d)
GO
create or alter function movieReleasedAfter(@mai_mare_ca INT)
	returns table
	return

	SELECT * FROM movie m
	WHERE m.date>'2021-01-01' and  movieID IN (
		SELECT movieID
		FROM cinema_production
		GROUP BY movieID
		HAVING count(*)> @mai_mare_ca
	)
	
GO

SELECT * FROM  movieReleasedAfter(1)
/*
company:
	companyID primary key
	name

stage director:
	directoID primaty key
	name
	awards
movie:
	movieID primary key
	name
	date
	companyID foreign key
	directorID foreign key

cinema production:
	production id primary key
	title
	movieid foreign key

actor:
	actorID primary key
	name
	ranking

list:
	productionID foreign key
	actorID foreign key
	entryMoment
	primary key(productionID, actorID)



b) actor, enrty moment, production
add to list
c) the name of actors that appear 
in all cinema productions
d) all movie that have the relase date after
 '2018-01-01;and have at least p productions*/

