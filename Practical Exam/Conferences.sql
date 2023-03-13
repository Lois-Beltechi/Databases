CREATE TABLE  Institution (
	ID INTEGER PRIMARY KEY,
	name VARCHAR(255),
	website VARCHAR(255),
	budget INTEGER
)

CREATE TABLE  Researcher (
	ID INTEGER PRIMARY KEY,
	name VARCHAR(255),
	dob DATE,
	institutionID INTEGER references Institution(ID)


)

CREATE TABLE  ConferenceType (
	ID INTEGER PRIMARY KEY,
	name VARCHAR(255),
	description VARCHAR(255)

)

CREATE TABLE   Conference(
	ID INTEGER PRIMARY KEY,
	name VARCHAR(255),
	location VARCHAR(255),
	fee INTEGER,
	conferenceTypeID INTEGER references ConferenceType(ID)

)

CREATE TABLE  Session (
	ID INTEGER PRIMARY KEY,
	name VARCHAR(255),
	conferenceID INTEGER references Conference(ID)
)

CREATE TABLE   Papre(
	ID INTEGER PRIMARY KEY,
	title VARCHAR(255),
	sessionID INTEGER references Session(ID)

)


CREATE TABLE  Write (
	ID INTEGER PRIMARY KEY,
	parerID INTEGER references Papre(ID),
	researcherID INTEGER references Researcher(ID),
	UNIQUE(parerID,researcherID) 


)

INSERT INTO Institution (ID, name, website, budget) VALUES
(1, 'Harvard University', 'www.harvard.edu/', 420),
(2, 'Massachusetts Institute of Technology', 'www.mit.edu/', 180),
(3, 'Stanford University', 'www.stanford.edu/', 2900),
(4, 'California Institute of Technology', 'www.caltech.edu/', 320),
(5, 'University of Cambridge', 'www.cam.ac.uk/', 1200);

INSERT INTO Researcher (ID, name, dob, institutionID) VALUES
(1, 'John Smith', '1985-07-15', 1),
(2, 'Mary Johnson', '1990-02-22', 2),
(3, 'David Lee', '1988-11-12', 3),
(4, 'Jessica Brown', '1992-06-03', 4),
(5, 'Michael Davis', '1987-09-24', 5);

INSERT INTO ConferenceType (ID, name, description) VALUES
(1, 'Academic Conference', 'A conference for scholars and researchers to present and discuss their work.'),
(2, 'Industry Conference', 'A conference for professionals and experts in a specific industry to share their knowledge and insights.'),
(3, 'Trade Show', 'A conference that showcases products and services of a specific industry.');

INSERT INTO Conference (ID, name, location, fee, conferenceTypeID) VALUES
(1, 'IEEE International Conference on Robotics and Automation', 'Montreal, Canada', 800, 1),
(2, 'National Retail Federation Big Show', 'New York City, USA', 1200, 2),
(3, 'International CES', 'Las Vegas, USA', 1500, 3),
(4, 'American Society of Civil Engineers Annual Conference', 'Denver, USA', 900, 1),
(5, 'Consumer Electronics Show Asia', 'Shanghai, China', 1000, 3);

INSERT INTO Session (ID, name, conferenceID) VALUES
(1, 'Robot Perception', 1),
(2, 'Retail Innovation', 2),
(3, 'Smart Home Technology', 3),
(4, 'Sustainability in Civil Engineering', 4),
(5, 'Mobile Devices and Applications', 5);

INSERT INTO Papre (ID, title, sessionID) VALUES
(1, 'A Novel Method for Object Recognition in Cluttered Environments', 1),
(2, 'Revolutionizing In-Store Experience with Artificial Intelligence', 2),
(3, 'The Future of Smart Homes: Challenges and Opportunities', 3),
(4, 'Sustainable Pavement Materials and Design', 4),
(5, 'Exploring the Impact of Mobile Applications on Society', 5);

INSERT INTO Write (ID, parerID, researcherID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

DELETE FROM Write;
DELETE FROM Papre;
DELETE FROM Session;
DELETE FROM Conference;
DELETE FROM ConferenceType;
DELETE FROM Researcher;
DELETE FROM Institution;

Drop Table Write;
Drop Table Papre;
Drop Table Session;
Drop Table Conference;
Drop Table ConferenceType;
Drop Table Researcher;
Drop Table Institution;

GO
CREATE or alter PROCEDURE addWrite (@researcherID INT, @paperID INT, @ID INT)
AS
	IF @researcherID NOT in (SELECT ID From Researcher)
	BEGIN
		RAISERROR('No such researcher', 16, 1)
		RETURN -1
	END;

	IF @paperID NOT in (SELECT ID From Papre)
	BEGIN
		RAISERROR('No such paper', 16, 1)
		RETURN -1
	END;

	IF exists (SELECT * From  Write where @researcherID=researcherID and @paperID=parerID)
	BEGIN
		RAISERROR('Records already in the table', 16, 1)
		RETURN -1
	END;

	INSERT INTO Write VALUES (@ID,@paperID,@researcherID)
GO

exec addWrite 1,2,6

select * from Write

--b)

GO
create or alter view ResearcherPaperConference
AS
	SELECT a.name from Researcher a
	INNER JOIN Write w on w.researcherID=a.ID
	INNER JOIN Papre P on w.parerID=p.ID
	INNER JOIN Session s on s.ID=p.sessionID
	INNER JOIN Conference c on c.ID=s.conferenceID
	INNer JOIN ConferenceType ct on ct.ID=c.conferenceTypeID
	WHERE ct.name='Academic Conference'
GO

SELECT * FROM ResearcherPaperConference

--d)
GO
create or alter function conferencesWithPapers(@mai_mare_ca INT)
	returns table
	return

	SELECT * FROM Conference c
	WHERE c.ID in(
		SELECT s.conferenceID
		FROM Papre  p inner join Session S on p.sessionID=s.ID
		GROUP BY s.conferenceID
		HAVING count(*)> @mai_mare_ca
	)
	
GO

SELECT * FROM  conferencesWithPapers(0)