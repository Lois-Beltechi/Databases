use [Handball_CH]
--a)

--go
--create procedure setGoldenGlobeVotesFromPlayerTinyint as
--    alter table Player alter column golden_globe_votes tinyint

-- a) modify the type of a column
GO
/*
CREATE OR ALTER PROCEDURE setGoldenGlobeVotesFromPlayerDecimal 
AS
    ALTER TABLE Player ALTER COLUMN golden_globe_votes DECIMAL(4,2)

	--back to int
GO


CREATE OR ALTER PROCEDURE setGoldenGlobeVotesFromPlayerDecimal 
AS
    ALTER TABLE Player ALTER COLUMN golden_globe_votes int

	--back to int
GO*/


CREATE OR ALTER PROCEDURE setGoldenGlobeVotesFromPlayerInt
AS
	ALTER TABLE Player ALTER COLUMN kg float
go


CREATE OR ALTER PROCEDURE setGoldenGlobeVotesFromPlayerInt
AS
	
	ALTER TABLE Player ALTER COLUMN kg int
go


--b) add / remove a column

GO
CREATE OR ALTER PROCEDURE addPlayerPositionToMedicalTest 
AS
	ALTER TABLE Medical_test ADD player_position VARCHAR(100)


GO
CREATE OR ALTER PROCEDURE removePlayerPositionFromMedicalTest
AS
	ALTER TABLE Medical_test DROP COLUMN player_position


-- c) add/remove a DEFAULT constraint

GO
CREATE OR ALTER PROCEDURE addDefaultToGoldenGlobeVotesFromPlayer
AS
	ALTER TABLE Player ADD CONSTRAINT default_votes DEFAULT(0) FOR golden_globe_votes

GO
CREATE OR ALTER PROCEDURE removeDefaultFromGoldenGlobeVotesFromPlayer
AS
	ALTER TABLE Player DROP CONSTRAINT default_votes



-- g) create/drop a table
GO
CREATE OR ALTER PROCEDURE addTeamEmployee 
AS
	CREATE TABLE TeamEmployee (
		employee_id INT,
		employee_name VARCHAR(120) NOT NULL,
		employee_role VARCHAR(55) NOT NULL,
		salary INT,
		CONSTRAINT EMPLOYEE_PRIMARY_KEY PRIMARY KEY(employee_id),
		tid int NOT NULL -- team_id from Team
	)

GO 
CREATE OR ALTER PROCEDURE dropTeamEmployee
AS
	DROP TABLE TeamEmployee


-- d) add/remove a primary key
GO
CREATE OR ALTER PROCEDURE addRoleAndNamePrimaryKeyTeamEmployee
AS
	ALTER TABLE TeamEmployee
		DROP CONSTRAINT EMPLOYEE_PRIMARY_KEY
	ALTER TABLE TeamEmployee
		ADD CONSTRAINT EMPLOYEE_PRIMARY_KEY PRIMARY KEY(employee_name, employee_role)

GO 
CREATE OR ALTER PROCEDURE removeRoleAndNamePrimaryKeyTeamEmployee
AS
	ALTER TABLE TeamEmployee
		DROP CONSTRAINT EMPLOYEE_PRIMARY_KEY
	ALTER TABLE TeamEmployee
		ADD CONSTRAINT EMPLOYEE_PRIMARY_KEY PRIMARY KEY(employee_id)


-- e) add/remove a candidate key
GO
CREATE OR ALTER PROCEDURE addCandidateKeyFan 
AS	
	ALTER TABLE Fan
		ADD CONSTRAINT FAN_CANDIDATE_KEY UNIQUE(name, age, country)


GO
CREATE OR ALTER PROCEDURE removeCandidateKeyFan
AS
	ALTER TABLE Fan
		DROP CONSTRAINT FAN_CANDIDATE_KEY


-- f) add / remove a foreign key
GO
CREATE OR ALTER PROCEDURE addForeignKeyTeamEmployee 
AS
	ALTER TABLE TeamEmployee
		ADD CONSTRAINT EMPLOYEE_FOREIGN_KEY FOREIGN KEY(tid) REFERENCES Team(tid)

GO
CREATE OR ALTER PROCEDURE removeForeignKeyTeamEmployee
AS
	ALTER TABLE TeamEmployee
		DROP CONSTRAINT EMPLOYEE_FOREIGN_KEY


-------------------------------------------------------------------

-- a table that contains the current version of the database schema
/*
CREATE TABLE versionTable (
	version INT
)

INSERT INTO versionTable 
VALUES
	(1) -- this is the initial version


-- a table that contains the initial version, the (final )version after the execution of the procedure 
--and the procedure(name) that changes the table in this way
CREATE TABLE procedureTable (
	initial_version INT,
	final_version INT,
	procedure_name VARCHAR(MAX),
	PRIMARY KEY (initial_version, final_version)
)

INSERT INTO procedureTable
VALUES
	(1, 2, 'setGoldenGlobeVotesFromPlayerDecimal'),
	(2, 1, 'setGoldenGlobeVotesFromPlayerInt'),
	(2, 3, 'addPlayerPositionToMedicalTest'), 
	(3, 2, 'removePlayerPositionFromMedicalTest'),
	(3, 4, 'addDefaultToGoldenGlobeVotesFromPlayer'),
	(4, 3, 'removeDefaultFromGoldenGlobeVotesFromPlayer'),
	(4, 5, 'addTeamEmployee'),
	(5, 4, 'dropTeamEmployee'),
	(5, 6, 'addRoleAndNamePrimaryKeyTeamEmployee'),
	(6, 5, 'removeRoleAndNamePrimaryKeyTeamEmployee'),
	(6, 7, 'addCandidateKeyFan'),
	(7, 6, 'removeCandidateKeyFan'),
	(7, 8, 'addForeignKeyTeamEmployee'),
	(8, 7, 'removeForeignKeyTeamEmployee')



-- procedure to bring the database to the specified version
GO
CREATE OR ALTER PROCEDURE goToVersion(@newVersion INT) 
AS
	DECLARE @current_version INT
	DECLARE @procedureName VARCHAR(MAX)

	SELECT @current_version = version FROM versionTable

	IF (@newVersion > (SELECT MAX(final_version) FROM procedureTable) OR @newVersion < 1)
		RAISERROR ('Bad version', 10, 1)
	ELSE

	BEGIN
		IF @newVersion = @current_version
			PRINT('You are already on this version!');
		ELSE

		BEGIN
			IF @current_version > @newVersion				--down cr_version
			BEGIN
				WHILE @current_version > @newVersion 
					BEGIN
						SELECT @procedureName = procedure_name FROM procedureTable WHERE initial_version = @current_version AND final_version = @current_version-1
						PRINT('Executing ' + @procedureName);
						EXEC (@procedureName)
						SET @current_version = @current_version - 1
					END
			END

			IF @current_version < @newVersion
			BEGIN

				WHILE @current_version < @newVersion         --up cr_version
					BEGIN
						SELECT @procedureName = procedure_name FROM procedureTable WHERE initial_version = @current_version AND final_version = @current_version+1
						PRINT('Executing ' + @procedureName);
						EXEC (@procedureName)
						SET @current_version = @current_version + 1
					END
			END

			UPDATE versionTable SET version = @newVersion			
		END
	END


EXEC goToVersion 4

SELECT *
FROM versionTable

SELECT *
FROM procedureTable

--PRINT('da');

*/


create table versionTable (
    version int
)

insert into versionTable values (1) -- initial version

create table proceduresTable (
    fromVersion int,
    toVersion int,
    primary key (fromVersion, toVersion),
    nameProc varchar(max)
)

INSERT INTO proceduresTable
VALUES
	(1, 2, 'setGoldenGlobeVotesFromPlayerDecimal'),
	(2, 1, 'setGoldenGlobeVotesFromPlayerInt'),
	(2, 3, 'addPlayerPositionToMedicalTest'), 
	(3, 2, 'removePlayerPositionFromMedicalTest'),
	(3, 4, 'addDefaultToGoldenGlobeVotesFromPlayer'),
	(4, 3, 'removeDefaultFromGoldenGlobeVotesFromPlayer'),
	(4, 5, 'addTeamEmployee'),
	(5, 4, 'dropTeamEmployee'),
	(5, 6, 'addRoleAndNamePrimaryKeyTeamEmployee'),
	(6, 5, 'removeRoleAndNamePrimaryKeyTeamEmployee'),
	(6, 7, 'addCandidateKeyFan'),
	(7, 6, 'removeCandidateKeyFan'),
	(7, 8, 'addForeignKeyTeamEmployee'),
	(8, 7, 'removeForeignKeyTeamEmployee')
go

create or alter procedure goToVersion(@newVersion int) as
    declare @curr int
    declare @var varchar(max)
    select @curr=version from versionTable

    if @newVersion > (select max(toVersion) from proceduresTable)
        raiserror ('Bad version', 10, 1)

    while @curr > @newVersion begin
        select @var=nameProc from proceduresTable where fromVersion=@curr and toVersion=@curr-1
        exec (@var)
        set @curr=@curr-1
    end

    while @curr < @newVersion begin
        select @var=nameProc from proceduresTable where fromVersion=@curr and toVersion=@curr+1
        exec (@var)
        set @curr=@curr+1
    end

    update versionTable set version=@newVersion

	

execute goToVersion 1


SELECT *
FROM versionTable

SELECT *
FROM proceduresTable

--SELECT * 
--FROM TeamEmployee

--select * from Medical_test