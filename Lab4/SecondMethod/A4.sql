use [Handball_CH]

-- # VIEWS
---1. a view with a SELECT statement operating on one table;
GO
CREATE OR ALTER VIEW bestPLayers AS
	SELECT P.name, P.golden_globe_votes
	FROM Player P
	WHERE P.golden_globe_votes > 90


---2. a view with a SELECT statement that operates on at least 2 different tables 
--and contains at least one JOIN operator;

-- Player, Coach
GO
CREATE OR ALTER VIEW players_trainedByCoaches AS
	SELECT P.name, C.coach_name
	FROM Player P INNER JOIN Coach C on C.pid=P.pid


-- 3. a view with a SELECT statement that has a GROUP BY clause and operates on at least 2 tables
GO
CREATE OR ALTER VIEW groupPlayersByFans AS
	SELECT P.pid, P.name, COUNT(*) AS fans
	FROM Player P 
	INNER JOIN FanOfPlayer FP ON P.pid = FP.pid
	GROUP BY P.pid, P.name


GO
-----------------------------------------------------------------------------------------------------------------------------

-- 1 primary key, no FR key: Coach
-- 1 PK, 1 FR KEY: Physician
-- 2 PK multicolumn : Has_To_DO


--Procedures to simplify the process for adding specific tests, tables, views and for creating the connections between them

-- # ADD             *********************************************************************
GO
CREATE OR ALTER PROCEDURE addToTables (@tableName VARCHAR(50)) AS
BEGIN
	IF @tableName IN (SELECT [Name] from [Tables]) 
	BEGIN
		PRINT 'Table already present in Tables'
		RETURN
	END

	IF @tableName NOT IN (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES)
	BEGIN
		PRINT 'Table not present in the database'
		RETURN
	END

	INSERT INTO [Tables] ([Name]) 
	VALUES
		(@tableName)
END


GO
CREATE OR ALTER PROCEDURE addToViews (@viewName VARCHAR(50)) AS
BEGIN
	IF @viewName IN (SELECT [Name] from [Views]) 
	BEGIN
		PRINT 'View already present in Views'
		RETURN
	END

	IF @viewName NOT IN (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS)
	BEGIN
		PRINT 'View not present in the database'
		RETURN
	END

	INSERT INTO [Views] ([Name]) 
	VALUES
		(@viewName)
END


GO
CREATE OR ALTER PROCEDURE addToTests (@testName VARCHAR(50)) AS
BEGIN
	IF @testName IN (SELECT [Name] from [Tests]) 
	BEGIN
		PRINT 'Test already present in Tests'
		RETURN
	END
	                     --field
	INSERT INTO [Tests] ([Name]) 
	VALUES
		(@testName)
END

------------------- ************************************************************************************

-- # connect

---- TestTables – junction table between Tests and Tables (which tables take part in which tests);

GO
CREATE OR ALTER PROCEDURE connectTableToTest (@tableName VARCHAR(50), @testName VARCHAR(50), @rows INT, @pos INT) AS
BEGIN
	IF @tableName NOT IN (SELECT [Name] FROM [Tables]) 
		BEGIN
			PRINT 'Table not present in Tables'
			RETURN
		END

	IF @testName NOT IN (SELECT [Name] FROM [Tests])
		BEGIN
			PRINT 'Test not present in Test'
			RETURN
		END

	IF EXISTS( 
		SELECT * 
		FROM TestTables T1 JOIN Tests T2 ON T1.TestID = T2.TestID
		WHERE T2.[Name] = @testName AND Position = @pos   --Test of TestTables with given @testname and @pos
	)
		BEGIN
			PRINT 'Position provided conflicts with previous positions'     
			RETURN
		END

	INSERT INTO [TestTables] (TestID, TableID, NoOfRows, Position) 
	VALUES (
		(SELECT [Tests].TestID FROM [Tests] WHERE [Name] = @testName),           --- Tests
		(SELECT [Tables].TableID FROM [Tables] WHERE [Name] = @tableName),        -- Tables
		@rows,																	
		@pos																	
	)
END


--TestViews – junction table between Tests and Views (which views take part in which tests);
GO
CREATE OR ALTER PROCEDURE connectViewToTest (@viewName VARCHAR(50), @testName VARCHAR(50)) AS
BEGIN
	IF @viewName NOT IN (SELECT [Name] FROM [Views]) 
		BEGIN
			PRINT 'View not present in Views'
			RETURN
		END

	IF @testName NOT IN (Select [Name] FROM [Tests]) 
		BEGIN
			PRINT 'Test not present in Tests'
			RETURN
		END

	INSERT INTO [TestViews] (TestID, ViewID)
	VALUES(
		(SELECT [Tests].TestID FROM [Tests] WHERE [Name] = @testName), --   Tests, @testname
		(SELECT [Views].ViewID FROM [Views] WHERE [Name] = @viewName) --    Views, @viewname
	)
END


----- **************************************************************

-- # Delete

-- Delete data from a table
GO
CREATE OR ALTER PROCEDURE deleteDataFromTable (@tableID INT) AS
BEGIN
	IF @tableID NOT IN (SELECT [TableID] FROM [Tables])
	BEGIN
		PRINT 'Table not present in Tables.'
		RETURN
	END
	DECLARE @tableName NVARCHAR(50) = (SELECT [Name] FROM [Tables] WHERE TableID = @tableID) -- Name OF table based on the given TableID
	PRINT 'Delete data from table ' + @tableName
	DECLARE @query NVARCHAR(100) = N'DELETE FROM ' + @tableName
	PRINT @query
	EXEC sp_executesql @query    
END


-- Delete data from all the tables involved in a test
GO
CREATE OR ALTER PROCEDURE deleteDataFromAllTables (@testID INT) AS
BEGIN
	IF @testID NOT IN (SELECT [TestID] FROM [Tests])
	BEGIN
		PRINT 'Test not present in Tests.'
		RETURN
	END
	PRINT 'Delete data from all tables for the test ' + CONVERT(VARCHAR, @testID) --Test ID x has data in different tables; Delete all
	DECLARE @tableID INT 
	DECLARE @pos INT    
	-- cursor to iterate through the tables in the descending order of their position
	DECLARE allTableCursorDesc CURSOR LOCAL FOR				-- go through all tables
		SELECT T1.TableID, T1.Position 
		FROM TestTables T1									-- TestTables T1
		INNER JOIN Tests T2 ON T2.TestID = T1.TestID		-- Tests T2      based on TESTid
		WHERE T2.TestID = @testID							--@testID= T2.TestID  desired test
		ORDER BY T1.Position DESC
	OPEN allTableCursorDesc
	FETCH allTableCursorDesc INTO @tableID, @pos -- primu table deja s-o pus in tableID, POS
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		EXEC deleteDataFromTable @tableID   --stergi pe rand date
		FETCH NEXT FROM allTableCursorDesc INTO @tableID, @pos
	END
	CLOSE allTableCursorDesc
	DEALLOCATE allTableCursorDesc
END

---------------**************************************************

-- # insert

-- Insert data into a specific table; random data!
GO
CREATE OR ALTER PROCEDURE insertDataIntoTable (@testRunID INT, @testID INT, @tableID INT) AS
BEGIN
	IF @testID NOT IN (SELECT [TestID] FROM [Tests])                 --Test
	BEGIN
		PRINT 'Test not present in Tests.'
		RETURN
	END

	IF @testRunID NOT IN (SELECT [TestRunID] FROM [TestRuns])		 --TestRuns
	BEGIN
		PRINT 'Test run not present in TestRuns.'
		RETURN
	END

	IF @tableID NOT IN (SELECT [TableID] FROM [Tables])
	BEGIN
		PRINT 'Table not present in Tables.'						--Tables
		RETURN
	END

	DECLARE @startTime DATETIME = SYSDATETIME()
	DECLARE @tableName VARCHAR(50) = (
		SELECT [Name] 
		FROM [Tables]                      ----- Tables -> Select Table w/ TableID given as a parameter
		WHERE TableID = @tableID
	)
	PRINT 'Insert data into table ' + @tableName
	DECLARE @numberOfRows INT = (
		SELECT [NoOfRows]						        -- take rows, no. of data from tablename
		FROM [TestTables]                               -- TestTables, toate teste + tabele
		WHERE TestID = @testID AND TableID = @tableID   --TableID de sus, TestID
	)
	-- generate random data in the table
	EXEC generateRandomDataForTable @tableName, @numberOfRows			-- Generate RANDOM DATA from other query
	DECLARE @endTime DATETIME = SYSDATETIME()
	INSERT INTO TestRunTables(TestRunID, TableID, StartAt, EndAt)       -- TestRunTables = count time 
	VALUES (@testRunID, @tableID, @startTime, @endTime)
END


-- Insert data into all the tables involved in a test
GO
CREATE OR ALTER PROCEDURE insertDataIntoAllTables (@testRunID INT, @testID INT) AS
BEGIN
	IF @testID NOT IN (SELECT [TestID] FROM [Tests])
	BEGIN
		PRINT 'Test not present in Tests.'
		RETURN
	END

	IF @testRunID NOT IN (SELECT [TestRunID] FROM [TestRuns])
	BEGIN
		PRINT 'Test run not present in TestRuns.'
		RETURN
	END

	PRINT 'Insert data in all the tables for the test ' + CONVERT(VARCHAR, @testID)		-- INSERT ALL DATA ;; from test ID __
	DECLARE @tableID INT
	DECLARE @pos INT
	--cursor to ITERATE through the TABLES in ASCENDING order of their POSITION
	DECLARE allTableCursorAsc CURSOR LOCAL FOR
		SELECT T1.TableID, T1.Position
		FROM TestTables T1
		INNER JOIN Tests T2 ON T2.TestID = T1.TestID			--TestTables
		WHERE T1.TestID = @testID								--Tests
		ORDER BY T1.Position ASC								--By Position

	OPEN allTableCursorAsc
	FETCH allTableCursorAsc INTO @tableID, @pos
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC insertDataIntoTable @testRunID, @testID, @tableID
		FETCH NEXT FROM allTableCursorAsc INTO @tableID, @pos
	END
	CLOSE allTableCursorAsc
	DEALLOCATE allTableCursorAsc
END
-----------*******

-- # select

-- Select data from a view
GO
CREATE OR ALTER PROCEDURE selectDataFromView (@viewID INT, @testRunID INT) AS
BEGIN
	IF @viewID NOT IN (SELECT [ViewID] FROM [Views])
	BEGIN
		PRINT 'View not present in Views.'
		RETURN
	END

	IF @testRunID NOT IN (SELECT [TestRunID] FROM [TestRuns])
	BEGIN
		PRINT 'Test run not present in TestRuns.'
		RETURN
	END

	DECLARE @startTime DATETIME = SYSDATETIME()                               -- TIME
	DECLARE @viewName VARCHAR(100) = (
		SELECT [Name]
		FROM [Views]										-- Views ; ViewName = select Name of View after given ViewID
		WHERE ViewID = @viewID
	)
	PRINT 'Selecting data from the view ' + @viewName
	DECLARE @query NVARCHAR(150) = N'SELECT * FROM ' + @viewName
	EXEC sp_executesql @query												-- query automat care  AFISEAZa VIEWs

	DECLARE @endTime DATETIME = SYSDATETIME()
	INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt)
	VALUES (@testRunID, @viewID, @startTime, @endTime)
END


-- Select data from all the views
GO
CREATE OR ALTER PROCEDURE selectAllViews (@testRunID INT, @testID INT) AS
BEGIN
	IF @testID NOT IN (SELECT [TestID] FROM [Tests])
	BEGIN
		PRINT 'Test not present in Tests.'
		RETURN
	END

	IF @testRunID NOT IN (SELECT [TestRunID] FROM [TestRuns])
	BEGIN
		PRINT 'Test run not present in TestRuns.'
		RETURN
	END

	PRINT 'Selecting data from all the views from the test ' + CONVERT(VARCHAR, @testID)
	DECLARE @viewID INT
	--cursor to ITERATE through the VIEWS
	DECLARE selectAllViewsCursor CURSOR LOCAL FOR
		SELECT T1.ViewID FROM TestViews T1
		INNER JOIN Tests T2 ON T2.TestID = T1.TestID                 --TestViews
		WHERE T1.TestID = @testID									 --Tests

	OPEN selectAllViewsCursor
	FETCH selectAllViewsCursor INTO @viewID
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		EXEC selectDataFromView @viewID, @testRunID              -- primeste run ID test; viewID il scoate din TestViews/Tests;;; --> Selecteaza Data din VIEW 
		FETCH NEXT FROM selectAllViewsCursor INTO @viewID
	END
	CLOSE selectAllViewsCursor
	DEALLOCATE selectAllViewsCursor
END


--------*****************

-- # run

-- Run a test
GO
CREATE OR ALTER PROCEDURE runTest (@testID INT, @description VARCHAR(MAX)) AS
BEGIN
	IF @testID NOT IN (SELECT [TestID] FROM [Tests])
	BEGIN
		PRINT 'Test not present in Tests.'
		RETURN
	END

	PRINT 'Running test with the id ' + CONVERT(VARCHAR, @testID)
	INSERT INTO TestRuns([Description]) 
	VALUES (@description)
	DECLARE @testRunID INT = (
		SELECT MAX(TestRunID)
		FROM TestRuns
	)
	EXEC deleteDataFromAllTables @testID

	DECLARE @startTime DATETIME = SYSDATETIME()					-- time la run a test...
	EXEC insertDataIntoAllTables @testRunID, @testID			-- insert TO ALL TABLES										
	EXEC selectAllViews @testRunID, @testID						--selectAllViews
	DECLARE @endTime DATETIME = SYSDATETIME()					-- done time
	EXEC deleteDataFromAllTables @testID						-- delete data!

	UPDATE [TestRuns] SET StartAt = @startTime, EndAt = @endTime		-- update la timp, start, finish
	DECLARE @timeDifference INT = DATEDIFF(SECOND, @startTime, @endTime)		
	PRINT 'The test with id ' + CONVERT(VARCHAR, @testID) + ' took ' + CONVERT(VARCHAR, @timeDifference) + ' seconds.'  
END



-- Run all the tests
GO
CREATE OR ALTER PROCEDURE runAllTests AS
BEGIN
	DECLARE @testName VARCHAR(50)
	DECLARE @testID INT
	DECLARE @description VARCHAR(2000)
	--cursor to iterate through the tests
	DECLARE allTestsCursor CURSOR LOCAL FOR
		SELECT *
		FROM Tests												-- TESTS

	OPEN allTestsCursor
	FETCH allTestsCursor INTO @testID, @testName     -- primul rand din Tests cu datele resp in testID, testName
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 'Running ' + @testName
		SET @description = 'Test results for test with the ID ' + CAST(@testID AS VARCHAR(2))
		EXEC runTest @testID, @description
		FETCH NEXT FROM allTestsCursor INTO @testID, @testName
	END
	CLOSE allTestsCursor
	DEALLOCATE allTestsCursor
END

---***************************************

-- # create test
--select * from TestRuns

DELETE FROM TestRuns
DELETE FROM TestRunTables
DELETE FROM TestRunViews
DELETE FROM TestTables
DELETE FROM TestViews
DELETE FROM [Views]
DELETE FROM Tests
DELETE FROM [Tables]


-- CREATE THE TESTS

-- first test
--					 1 PK									 ||					1 FK, 1PK                                ||                  2 PK's m to n
-- a table with no foreign key and a single-column primary key, a table with a foreign key and a single-column primary key and a table with a multi-column primary key

-- a view with a SELECT statement that has a GROUP BY clause and operates on at least 2 tables
EXEC addToViews 'groupPlayersByFans'
EXEC addToTests 'Test1'
EXEC addToTables 'Player'
EXEC connectTableToTest 'Player', 'Test1', 10, 1
EXEC addToTables 'Fan'
EXEC connectTableToTest 'Fan', 'Test1', 10, 2
EXEC addToTables 'FanOfPlayer'
EXEC connectTableToTest 'FanOfPlayer', 'Test1', 10, 3
EXEC connectViewToTest 'groupPlayersByFans', 'Test1'


-- second test
-- a table with a single-column primary key   ;;; -- 1 PK
-- a view with a SELECT statement operating on one table
EXEC addToViews 'bestPLayers'
EXEC addToTests 'Test2'
EXEC addToTables 'Player'			
EXEC connectTableToTest 'Player', 'Test2', 10, 1
EXEC connectViewToTest 'bestPLayers', 'Test2'

-- third test
-- a view with a SELECT statement operating on at least two tables
-- a table with no foreign key and a single-column primary key and a table with a foreign key;  ->1 PK + 1 FK
EXEC addToViews 'players_trainedByCoaches'
EXEC addToTests 'Test3'
EXEC addToTables 'Match'
EXEC connectTableToTest 'Match', 'Test3', 10, 1
EXEC addToTables 'Player'
EXEC connectTableToTest 'Player', 'Test3', 10, 2
EXEC addToTables 'Coach'
EXEC connectTableToTest 'Coach', 'Test3', 10, 3
EXEC connectViewToTest 'players_trainedByCoaches', 'Test3'


EXEC runAllTests

SELECT *
FROM [Views]

SELECT *
FROM [Tables]

SELECT *
FROM [Tests]

SELECT *
FROM [TestTables]

SELECT *
FROM [TestViews]

SELECT *
FROM [TestRuns]

SELECT *
FROM [TestRunTables]

SELECT *
FROM [TestRunViews]