/*
Query
1

Conferences
	[]
ConferenceTypes
Sessions  
+ SesionPapers
PaPers
	title
	Coauthered by	Several Researches
	[foreign key catre researches]
+ PapersAuthors
Researchers
	name
	DOB
	A researcher can write multiple papers -> 1:m


Institutions
	[name
	website
	budget

*/


-- drop the Author table
DROP TABLE Author;

-- drop the Paper table
DROP TABLE Paper;

-- drop the Session table
DROP TABLE Session;

-- drop the Conference table
DROP TABLE Conference;

-- drop the ConferenceType table
DROP TABLE ConferenceType;

-- drop the Researcher table
DROP TABLE Researcher;

-- drop the Institution table
DROP TABLE Institution;


CREATE TABLE Institution (
    institution_id INT PRIMARY KEY,
    name VARCHAR(255),
    website VARCHAR(255),
    budget DECIMAL(10,2)
);

CREATE TABLE Researcher (
    researcher_id INT PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE,
    institution_id INT,
    FOREIGN KEY (institution_id) REFERENCES Institution(institution_id)
);

CREATE TABLE ConferenceType (
    conference_type_id INT PRIMARY KEY,
    name VARCHAR(255),
    description VARCHAR(255)
);

CREATE TABLE Conference (
    conference_id INT PRIMARY KEY,
    name VARCHAR(255),
    location VARCHAR(255),
    fee DECIMAL(10,2),
    conference_type_id INT,
    FOREIGN KEY (conference_type_id) REFERENCES ConferenceType(conference_type_id)
);

CREATE TABLE Session (
    session_id INT PRIMARY KEY,
    name VARCHAR(255),
    conference_id INT,
    FOREIGN KEY (conference_id) REFERENCES Conference(conference_id)
);

CREATE TABLE Paper (
    paper_id INT PRIMARY KEY,
    title VARCHAR(255),
    conference_id INT,
    session_id INT,
    FOREIGN KEY (conference_id) REFERENCES Conference(conference_id),
    FOREIGN KEY (session_id) REFERENCES Session(session_id)
);

CREATE TABLE Author (
    paper_id INT,
    researcher_id INT,
    PRIMARY KEY (paper_id, researcher_id),
    FOREIGN KEY (paper_id) REFERENCES Paper(paper_id),
    FOREIGN KEY (researcher_id) REFERENCES Researcher(researcher_id)
);

-- delete data from the Author table
DELETE FROM Author;

-- delete data from the Paper table
DELETE FROM Paper;

-- delete data from the Session table
DELETE FROM Session;

-- delete data from the Conference table
DELETE FROM Conference;

-- delete data from the ConferenceType table
DELETE FROM ConferenceType;

-- delete data from the Researcher table
DELETE FROM Researcher;

-- delete data from the Institution table
DELETE FROM Institution;



INSERT INTO Institution (institution_id, name, website, budget) VALUES (1, 'University of XYZ', 'www.xyz.edu', 1000000.00);
INSERT INTO Institution (institution_id, name, website, budget) VALUES (2, 'Research Institute ABC', 'www.abc.com', 2000000.00);
INSERT INTO Institution (institution_id, name, website, budget) VALUES (3, 'National Laboratory LMN', 'www.lmn.gov', 3000000.00);


INSERT INTO Researcher (researcher_id, name, date_of_birth, institution_id) VALUES (1, 'John Doe', '1990-01-01', 1);
INSERT INTO Researcher (researcher_id, name, date_of_birth, institution_id) VALUES (2, 'Jane Smith', '1995-02-15', 2);
INSERT INTO Researcher (researcher_id, name, date_of_birth, institution_id) VALUES (3, 'Robert Johnson', '1985-03-20', 3);
INSERT INTO Researcher (researcher_id, name, date_of_birth, institution_id) VALUES (4, 'Roberta Johnson', '1985-03-20', 1);


INSERT INTO ConferenceType (conference_type_id, name, description) VALUES (1, 'Computer Science', 'International conference on computer science and related fields');
INSERT INTO ConferenceType (conference_type_id, name, description) VALUES (2, 'Physics', 'International conference on physics and related fields');
INSERT INTO ConferenceType (conference_type_id, name, description) VALUES (3, 'Engineering', 'International conference on engineering and related fields');

INSERT INTO Conference (conference_id, name, location, fee, conference_type_id) VALUES (1, 'ICCS 2021', 'New York', 200.00, 1);
INSERT INTO Conference (conference_id, name, location, fee, conference_type_id) VALUES (2, 'ICP 2021', 'Paris', 250.00, 2);
INSERT INTO Conference (conference_id, name, location, fee, conference_type_id) VALUES (3, 'ICE 2021', 'Sydney', 300.00, 3);

INSERT INTO Session (session_id, name, conference_id) VALUES (1, 'A', 1);
INSERT INTO Session (session_id, name, conference_id) VALUES (2, 'Session B', 1);
INSERT INTO Session (session_id, name, conference_id) VALUES (3, 'Session C', 2);

INSERT INTO Paper (paper_id, title, conference_id, session_id) VALUES (1, 'Paper 1', 1, 1);
INSERT INTO Paper (paper_id, title, conference_id, session_id) VALUES (2, 'Paper 2', 1, 2);
INSERT INTO Paper (paper_id, title, conference_id, session_id) VALUES (3, 'Paper 3', 2, 3);

INSERT INTO Author (paper_id, researcher_id) VALUES (1, 1);
INSERT INTO Author (paper_id, researcher_id) VALUES (1, 2);
INSERT INTO Author (paper_id, researcher_id) VALUES (2, 3);


SELECT * FROM Institution;
SELECT * FROM Researcher;
SELECT * FROM ConferenceType;
SELECT * FROM Conference;
SELECT * FROM Session;
SELECT * FROM Paper;
SELECT * FROM Author;


-- 2)
--Implement a stored procedure that receives a researcher and a paper, and adds the corresponding autorship association to the database. If the researcher is already
--associated with the paper, a warning message is displayed to the user.


CREATE OR ALTER PROCEDURE AddAuthorship (@researcher_id INT, @paper_id INT)
AS
BEGIN
    DECLARE @is_associated INT

    SET @is_associated = (SELECT COUNT(*) FROM Author WHERE researcher_id = @researcher_id AND paper_id = @paper_id)

    IF @is_associated = 0
    BEGIN
        INSERT INTO Author (researcher_id, paper_id) VALUES (@researcher_id, @paper_id)
        PRINT 'Authorship association added successfully.'
    END
    ELSE
    BEGIN
        PRINT 'Warning: Researcher is already associated with the paper.'
    END
END

EXEC AddAuthorship @researcher_id = 1, @paper_id = 1


--c)  Names of RESEARCHERS with accepted PAPERS in ALL CONFERENCES_OF_TYPE 'A'

--Create a view that shows the names of the researchers with accepted papers in all conferences of type 'A'.

/*
GO
create or alter view ShowAllCardNumbersUsedInAllATMs
AS
	SELECT Number FROM Card C
	WHERE 
	NOT EXISTS
    (SELECT ATMID FROM ATM -- n-o sa fie niciuna la card1
    EXCEPT
    SELECT ATMID FROM Transactions T
    WHERE T.CardID = C.CardID
	)
GO

SELECT * FROM ShowAllCardNumbersUsedInAllATMs

*/
GO
CREATE or alter VIEW accepted_papers_type_a 
AS
	SELECT DISTINCT Researcher.name
	FROM Researcher
	JOIN Author ON Researcher.researcher_id = Author.researcher_id
	JOIN Paper ON Author.paper_id = Paper.paper_id
	JOIN Conference ON Paper.conference_id = Conference.conference_id
	JOIN ConferenceType ON Conference.conference_type_id = ConferenceType.conference_type_id
	WHERE ConferenceType.name = 'A'
GO


SELECT * FROM accepted_papers_type_a


--Implement a function that returns the names of the conferences with at least P presented papers, where P is the function's Parameter

GO
CREATE FUNCTION get_conferences_with_at_least_p_papers(@P INT) 
	returns table
	return
        SELECT Conference.name
        FROM Conference
        JOIN Paper ON Conference.conference_id = Paper.conference_id
        GROUP BY Conference.name
        HAVING COUNT(Paper.paper_id) >= @P
 
GO


SELECT * FROM get_conferences_with_at_least_p_papers(1);
