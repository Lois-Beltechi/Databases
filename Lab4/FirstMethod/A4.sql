use [Handball_CH]


--- #cod suport
if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_Tables

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tables

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_TestRuns

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_TestRuns

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tests

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Tests

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_Views

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Views

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Tables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Tables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRunTables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRunViews]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRuns]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRuns]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestTables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestViews]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Tests]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Tests]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Views]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Views]

GO



CREATE TABLE [Tables] (

	[TableID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRunTables] (

	[TestRunID] [int] NOT NULL ,

	[TableID] [int] NOT NULL ,

	[StartAt] [datetime] NOT NULL ,

	[EndAt] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRunViews] (

	[TestRunID] [int] NOT NULL ,

	[ViewID] [int] NOT NULL ,

	[StartAt] [datetime] NOT NULL ,

	[EndAt] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRuns] (

	[TestRunID] [int] IDENTITY (1, 1) NOT NULL ,

	[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,

	[StartAt] [datetime] NULL ,

	[EndAt] [datetime] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestTables] (

	[TestID] [int] NOT NULL ,

	[TableID] [int] NOT NULL ,

	[NoOfRows] [int] NOT NULL ,

	[Position] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestViews] (

	[TestID] [int] NOT NULL ,

	[ViewID] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [Tests] (

	[TestID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [Views] (

	[ViewID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



ALTER TABLE [Tables] WITH NOCHECK ADD 

	CONSTRAINT [PK_Tables] PRIMARY KEY  CLUSTERED 

	(

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunTables] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRunTables] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID],

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunViews] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRunViews] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID],

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRuns] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRuns] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestTables] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestTables] PRIMARY KEY  CLUSTERED 

	(

		[TestID],

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestViews] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestViews] PRIMARY KEY  CLUSTERED 

	(

		[TestID],

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [Tests] WITH NOCHECK ADD 

	CONSTRAINT [PK_Tests] PRIMARY KEY  CLUSTERED 

	(

		[TestID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [Views] WITH NOCHECK ADD 

	CONSTRAINT [PK_Views] PRIMARY KEY  CLUSTERED 

	(

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunTables] ADD 

	CONSTRAINT [FK_TestRunTables_Tables] FOREIGN KEY 

	(

		[TableID]

	) REFERENCES [Tables] (

		[TableID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestRunTables_TestRuns] FOREIGN KEY 

	(

		[TestRunID]

	) REFERENCES [TestRuns] (

		[TestRunID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestRunViews] ADD 

	CONSTRAINT [FK_TestRunViews_TestRuns] FOREIGN KEY 

	(

		[TestRunID]

	) REFERENCES [TestRuns] (

		[TestRunID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestRunViews_Views] FOREIGN KEY 

	(

		[ViewID]

	) REFERENCES [Views] (

		[ViewID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestTables] ADD 

	CONSTRAINT [FK_TestTables_Tables] FOREIGN KEY 

	(

		[TableID]

	) REFERENCES [Tables] (

		[TableID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestTables_Tests] FOREIGN KEY 

	(

		[TestID]

	) REFERENCES [Tests] (

		[TestID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestViews] ADD 

	CONSTRAINT [FK_TestViews_Tests] FOREIGN KEY 

	(

		[TestID]

	) REFERENCES [Tests] (

		[TestID]

	),

	CONSTRAINT [FK_TestViews_Views] FOREIGN KEY 

	(

		[ViewID]

	) REFERENCES [Views] (

		[ViewID]

	)

GO


--- =======================================




-------------!!!!!!!!!!!!!!!!!!!!!!
-- generate a random string
-- # generators
GO

IF EXISTS (SELECT [name] FROM sys.objects 
            WHERE object_id = OBJECT_ID('generateRandomString'))
BEGIN
   DROP PROCEDURE generateRandomString;
END

IF EXISTS (SELECT [name] FROM sys.objects
			WHERE object_id = OBJECT_ID('generateRandomDataForTable'))
BEGIN
	DROP PROCEDURE generateRandomDataForTable
END

--procedure to generate a random string with a limited length
GO 
CREATE OR ALTER PROCEDURE generateRandomString @stringValue VARCHAR(10) OUTPUT AS
BEGIN
	DECLARE @length INT
	DECLARE @charPool VARCHAR(55)
	DECLARE @charPoolLength INT
	SET @charPool = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
	SET @charPoolLength = LEN(@charPool)
	SET @length = FLOOR(RAND() * 10 + 5)
	SET @stringValue = ''
	WHILE @length > 0
	BEGIN
		SET @stringValue = @stringValue + SUBSTRING(@charPool, CONVERT(INT, RAND() * @charPoolLength) + 1, 1)
		SET @length = @length - 1
	END
END

-- generate random data for a table

GO
CREATE OR ALTER PROCEDURE generateRandomDataForTable @tableName VARCHAR(50), @numberOfRows INT AS
BEGIN
	-- create a cursor to iterate through the NAMES of the COLUMN and their TYPES  (parcurge toate coloanele; datele)
	DECLARE dataCursor SCROLL CURSOR FOR
		SELECT COLUMN_NAME, DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS    ---?????????? Nu din handball???????????/
		WHERE TABLE_NAME = @tableName												--TABLE NAME
		ORDER by ORDINAL_POSITION						-- the place a column appears in a table

	-- query for the insert in tables
	DECLARE @insertQuery VARCHAR(MAX)

	DECLARE @columnName VARCHAR(200)
	DECLARE @dataType VARCHAR(10)

	DECLARE @intValue INT
	DECLARE @stringValue VARCHAR(50)
	DECLARE @checkIfPKQuery NVARCHAR(2000)
	DECLARE @hasPK INT

	OPEN dataCursor

	WHILE @numberOfRows > 0
	BEGIN
		SET @hasPK = 0
		SET @insertQuery = 'INSERT INTO ' + @tableName + ' VALUES('
		SET @checkIfPKQuery = N'SELECT @outputPK = COUNT(*) FROM ' + @tableName + ' WHERE '
		FETCH FIRST FROM dataCursor INTO @columnName, @dataType
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF COLUMNPROPERTY(OBJECT_ID(@tableName), @columnName, 'IsIdentity') = 0
			BEGIN
				-- check if the current column has a foreign key property and if it has, take its values from the referenced table
				IF EXISTS(
					SELECT *
					FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE C       --- ??????????????????????????????????????????????????
					WHERE C.CONSTRAINT_NAME like 'FK%' AND @columnName = C.COLUMN_NAME AND @tableName = C.TABLE_NAME)
					BEGIN
						-- get the name of the referenced table and the name of the referenced column
						DECLARE @referencedTable VARCHAR(50)
						DECLARE @referencedColumn VARCHAR(50)
						DECLARE @result TABLE([tableName] VARCHAR(50), [columnName] VARCHAR(50))
						INSERT INTO @result SELECT OBJECT_NAME (f.referenced_object_id) AS referenced_table_name,
						COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS referenced_column_name
						FROM sys.foreign_keys AS f
						INNER JOIN sys.foreign_key_columns AS fc ON f.object_id = fc.constraint_object_id
						WHERE fc.parent_object_id = OBJECT_ID(@tableName) AND COL_NAME(fc.parent_object_id, fc.parent_column_id) = @columnName

						SET @referencedTable = (SELECT TOP 1 [tableName] FROM @result)
						SET @referencedColumn = (SELECT TOP 1 [columnName] FROM @result)
						
						-- empty the table, otherwise it will always have at the top the first table and column found
						DELETE FROM @result

						-- int case
						IF @dataType = 'int'
							BEGIN
								-- get a random value from the referenced table
								DECLARE @getRandomFK NVARCHAR(1000)
								SET @getRandomFK = N'SELECT TOP 1 @intValue = [' + @referencedColumn + '] FROM ' + @referencedTable + ' ORDER BY NEWID()'
								EXEC sp_executesql @getRandomFK, N'@intValue INT OUTPUT', @intValue OUTPUT
								SET @insertQuery = @insertQuery + CAST(@intValue AS NVARCHAR(10)) + ','
							END
						ELSE
							-- string case
							IF @dataType = 'varchar'
								BEGIN
									-- get a random value from the values in the referenced table
									DECLARE @getStringQuery NVARCHAR(200)
									SET @getStringQuery = N'SELECT TOP 1 @stringValue = ['  + @referencedColumn + '] FROM ' + @referencedTable + ' T WHERE ' +
									@columnName + ' = T.' + @columnName + ' ORDER BY NEWID()'
									EXEC sp_executesql @getStringQuery, N'@stringValue VARCHAR(50) OUTPUT', @stringValue OUTPUT
									SET @insertQuery = @insertQuery + '''' + @stringValue + ''','
								END
					END
				ELSE
					-- not a foreign key, does not depend on another table
					BEGIN
						IF @dataType = 'int'
							BEGIN
								-- generate a random number
								SET @intValue = FLOOR(RAND() * 1000) + 1
								SET @insertQuery = @insertQuery + CAST(@intValue AS NVARCHAR(10)) + ','
							END
						ELSE
							IF @dataType = 'varchar'
								BEGIN
									-- generate a random string
									EXEC generateRandomString @stringValue OUTPUT
									SET @insertQuery = @insertQuery + '''' + @stringValue + '''' + ','
								END
							ELSE
								BEGIN
									SET @insertQuery = @insertQuery + 'NULL' + ','
								END
					END

				-- if the column has a primary key, create a query t check its validity
				-- this will also check for multicolumn primary keys
				IF EXISTS(
					SELECT *
					FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE
					WHERE TABLE_NAME = @tableName AND COLUMN_NAME = @columnName AND CONSTRAINT_NAME LIKE 'PK%')
					BEGIN
						SET @hasPK = 1
						IF @dataType = 'varchar'
							BEGIN
								SET @checkIfPKQuery = @checkIfPKQuery + @columnName + '=''' + @stringValue + ''' AND '
							END
						IF @dataType = 'int'
							BEGIN
								SET @checkIfPKQuery = @checkIfPKQuery + @columnName + '=' + CAST(@intValue AS VARCHAR(10)) + ' AND '
							END
					END
			END
			FETCH NEXT FROM dataCursor INTO @columnName, @dataType
		END
		-- insert only if the primary key is valid
		IF @hasPK = 1
			BEGIN
				SET @checkIfPKQuery = LEFT(@checkIfPKQuery, LEN(@checkIfPKQuery) - 4)
				DECLARE @outputPK INT
				EXEC sp_executesql @checkIfPKQuery, N'@outputPK INT OUTPUT', @outputPK OUTPUT
				IF @outputPK = NULL OR @outputPK = 0
					BEGIN
						SET @insertQuery = LEFT(@insertQuery, LEN(@insertQuery) - 1) + ')'
						EXEC (@insertQuery)
						SET @numberOfRows = @numberOfRows - 1
					END
			END
		ELSE
			-- in this case there is no primary key
			BEGIN 
				SET @insertQuery = LEFT(@insertQuery, LEN(@insertQuery) - 1) + ')'
				EXEC (@insertQuery)
				SET @numberOfRows = @numberOfRows - 1
			END
	END
	CLOSE dataCursor
	DEALLOCATE dataCursor
END



---------------!!!!!!!!!!!!!!!!!!!





-- dmn ajuta

-- # VIEWS
---1. a view with a SELECT statement operating on one table;
GO
CREATE OR ALTER VIEW bestPLayers AS
	SELECT P.name, P.golden_globe_votes
	FROM Player P
	WHERE P.golden_globe_votes > 90


---2. a view with a SELECT statement that operates on at least 2 different tables 
--and contains at least one JOIN operator;
GO
CREATE OR ALTER VIEW medical_TestsDoneByPhysicians AS
	SELECT M.type_of_medical_test, P.name
	FROM Medical_test M INNER JOIN Physician P on P.mid = M.mid


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
			PRINT 'Position provided conflicts with previous positions'     ---- ??????????????????????????????????????
			RETURN
		END

	INSERT INTO [TestTables] (TestID, TableID, NoOfRows, Position) 
	VALUES (
		(SELECT [Tests].TestID FROM [Tests] WHERE [Name] = @testName),           --- Tests
		(SELECT [Tables].TableID FROM [Tables] WHERE [Name] = @tableName),        -- Tables
		@rows,																	--rowurie
		@pos																	-- pos
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
	EXEC sp_executesql @query    -----------?????????????????????????????????????????????????????????????????/
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
	DECLARE @tableID INT -- !!!!
	DECLARE @pos INT    --- !!!!
	-- cursor to iterate through the tables in the descending order of their position
	DECLARE allTableCursorDesc CURSOR LOCAL FOR  -- parcurgem all tables
		SELECT T1.TableID, T1.Position 
		FROM TestTables T1                         -- TestTables T1
		INNER JOIN Tests T2 ON T2.TestID = T1.TestID     -- Tests T2      based on TESTid
		WHERE T2.TestID = @testID          --@testID= T2.TestID  testu dorit de noi
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
		FROM [Tables]                      ----- Tables -> Select Tabelu cu TableID dat ca parametru
		WHERE TableID = @tableID
	)
	PRINT 'Insert data into table ' + @tableName
	DECLARE @numberOfRows INT = (
		SELECT [NoOfRows]						        -- IA RANDURILE, nr. de date din tablename
		FROM [TestTables]                              -- TestTables, toate teste + tabele
		WHERE TestID = @testID AND TableID = @tableID  --TableID de sus, TestID???
	)
	-- generate random data in the table
	EXEC generateRandomDataForTable @tableName, @numberOfRows			-- GENERARE RANDOM DATA din alt query
	DECLARE @endTime DATETIME = SYSDATETIME()
	INSERT INTO TestRunTables(TestRunID, TableID, StartAt, EndAt)       -- TestRunTables = Timp initial, final 
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
		FROM [Views]								-- Views ; ViewName = Ia Name dupa ViewID
		WHERE ViewID = @viewID
	)
	PRINT 'Selecting data from the view ' + @viewName
	DECLARE @query NVARCHAR(150) = N'SELECT * FROM ' + @viewName
	EXEC sp_executesql @query												-- query automat/dinamic care executa si AFISEAZa VIEWurile ///

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
	DECLARE @startTime DATETIME = SYSDATETIME()					-- time la run a test...
	EXEC insertDataIntoAllTables @testRunID, @testID			-- insert TO ALL TABLES										
	EXEC selectAllViews @testRunID, @testID						--selectAllViews
	DECLARE @endTime DATETIME = SYSDATETIME()					-- done time
	EXEC deleteDataFromAllTables @testID						-- delete data!

	UPDATE [TestRuns] SET StartAt = @startTime, EndAt = @endTime		-- update la timp, start, finish
	DECLARE @timeDifference INT = DATEDIFF(SECOND, @startTime, @endTime)		-- pune-l in seccunda?
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
		FROM Tests												-- TESTS!!!

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


-- CREATE THE TESTS

-- first test
--					 1 PK									 ||					1 FK, 1PK                                ||                  2 PK's m to n
-- a table with no foreign key and a single-column primary key, a table with a foreign key and a single-column primary key and a table with a multi-column primary key

-- a view with a SELECT statement that has a GROUP BY clause and operates on at least 2 tables
EXEC addToViews 'groupPlayersByFans'
EXEC addToTests 'Test1'
--EXEC addToTables 'Coach'							--Manager
--EXEC connectTableToTest 'Coach', 'Test1', 500, 1
EXEC addToTables 'Player'
EXEC connectTableToTest 'Player', 'Test1', 500, 2
EXEC addToTables 'Fan'
EXEC connectTableToTest 'Fan', 'Test1', 500, 3
EXEC addToTables 'FanOfPlayer'
EXEC connectTableToTest 'FanOfPlayer', 'Test1', 250, 4
EXEC insertDataIntoTable 10, 1, 4
EXEC connectViewToTest 'groupPlayersByFans', 'Test1'



-- second test
-- a table with a single-column primary key   ;;; -- 1 PK
-- a view with a SELECT statement operating on one table
EXEC addToViews 'bestPLayers'
EXEC addToTests 'Test2'
EXEC addToTables 'Player'			--Producer; aka diferit
EXEC connectTableToTest 'Player', 'Test2', 500, 1
EXEC connectViewToTest 'bestPLayers', 'Test2'

-- third test
-- a view with a SELECT statement operating on at least two tables
-- a table with no foreign key and a single-column primary key and a table with a foreign key; ;;;;; ->1 PK + 1 FK
EXEC addToViews 'medical_TestsDoneByPhysicians'
EXEC addToTests 'Test3'

EXEC addToTables 'Medical_test'
EXEC connectTableToTest 'Medical_test', 'Test3', 10, 1

EXEC addToTables 'Physician'
EXEC connectTableToTest 'Physician', 'Test3', 10, 2

--EXEC addToTables 'Physician'
--EXEC connectTableToTest 'Physician', 'Test3', 500, 1
--EXEC addToTables 'Medical_test'
--EXEC connectTableToTest 'Medical_test', 'Test3', 500, 2

EXEC connectViewToTest 'medical_TestsDoneByPhysicians', 'Test3'

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