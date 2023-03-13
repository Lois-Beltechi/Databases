-- use database da
USE [Handball_CH];
IF OBJECT_ID(N'dbo.FanOfPlayer', N'U') IS NOT NULL  
   DROP TABLE [dbo].[FanOfPlayer];  
GO
IF OBJECT_ID(N'dbo.Fan', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Fan];  
GO
IF OBJECT_ID(N'dbo.Special_Guests_Veterans', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Special_Guests_Veterans];  
GO
IF OBJECT_ID(N'dbo.Physician', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Physician];  
GO
IF OBJECT_ID(N'dbo.Has_To_Do', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Has_To_Do];  
GO
IF OBJECT_ID(N'dbo.Medical_test', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Medical_test];  
GO
IF OBJECT_ID(N'dbo.Goes_To', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Goes_To];  
GO
IF OBJECT_ID(N'dbo.Training', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Training];  
GO
IF OBJECT_ID(N'dbo.Contract', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Contract];  
GO
IF OBJECT_ID(N'dbo.Have', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Have];  
GO
IF OBJECT_ID(N'dbo.Coach', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Coach];  
GO
IF OBJECT_ID(N'dbo.Player', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Player];  
GO
IF OBJECT_ID(N'dbo.Match', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Match];  
GO
IF OBJECT_ID(N'dbo.Participate', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Participate];  
GO
IF OBJECT_ID(N'dbo.Team', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Team];  
GO
IF OBJECT_ID(N'dbo.Handball_Championship', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Handball_Championship];  
GO
IF OBJECT_ID(N'dbo.Season', N'U') IS NOT NULL  
   DROP TABLE [dbo].[Season];  
GO



-- Handball_Championship 1-m with Season ;
CREATE TABLE Season
(season_id INT PRIMARY KEY NOT NULL,
season_type VARCHAR(80)
)

CREATE TABLE Handball_Championship
(hid INT PRIMARY KEY NOT NULL,
 season_id INT FOREIGN KEY REFERENCES Season(season_id) ON DELETE CASCADE ON UPDATE CASCADE,
championship_name VARCHAR(100) UNIQUE
)

CREATE TABLE Team
(tid INT PRIMARY KEY NOT NULL,
team_name VARCHAR(80),
team_country VARCHAR(50)
)

--m(Handball_Championdship):n(Teams);
CREATE TABLE Participate(
	hid INT FOREIGN KEY REFERENCES Handball_Championship(hid) ON DELETE CASCADE ON UPDATE CASCADE,
	tid INT FOREIGN KEY REFERENCES Team(tid) ON DELETE CASCADE ON UPDATE CASCADE,
	date VARCHAR(50),
	favourite_team VARCHAR(50),
	PRIMARY KEY (hid, tid)
);

--1(coach):n(matches);
CREATE TABLE Match(
	mid INT PRIMARY KEY NOT NULL,
	date VARCHAR(25),
	opponents VARCHAR(50) UNIQUE,
	place VARCHAR(50),

);

--1(coach):n(players)
-- ++1(Match)  : n(Players)
CREATE TABLE Player(
	pid INT PRIMARY KEY NOT NULL,
	name VARCHAR(25),
	height INT,
	kg INT,
	position VARCHAR(50),
	country VARCHAR(25),
	golden_globe_votes INT,
	age INT
);


--1 team - m coach
CREATE TABLE Coach(
	cid INT PRIMARY KEY NOT NULL,

	mid INT FOREIGN KEY REFERENCES Match(mid) ON DELETE CASCADE ON UPDATE CASCADE, -- Coach 1 : Matches (m)
	pid INT FOREIGN KEY REFERENCES Player(pid) ON DELETE CASCADE ON UPDATE CASCADE,--1(coach):n(players)

	coach_name VARCHAR(50),
	coach_phone_number VARCHAR(10) UNIQUE,
	coach_kg INT,
	coach_salary INT,
	no_of_teams_trained INT
);

--m(Coach):n(Teams);
CREATE TABLE Have(
	cid INT FOREIGN KEY REFERENCES Coach(cid) ON DELETE CASCADE ON UPDATE CASCADE,
	tid INT FOREIGN KEY REFERENCES Team(tid) ON DELETE CASCADE ON UPDATE CASCADE,
	tactics VARCHAR(50),
	PRIMARY KEY (cid, tid) -- not null
);

--1(Player):1(Contract) 
CREATE TABLE Contract(
	contract_id INT PRIMARY KEY NOT NULL,
	pid INT FOREIGN KEY REFERENCES Player(pid) ON DELETE CASCADE ON UPDATE CASCADE,
	name VARCHAR(25),
	date VARCHAR(50),
	remuneration INT,
	UNIQUE(pid)
);

CREATE TABLE Training(
	training_id INT PRIMARY KEY NOT NULL,
	mid INT FOREIGN KEY REFERENCES Match(mid) ON DELETE CASCADE ON UPDATE CASCADE, -- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	date VARCHAR(25),
	place VARCHAR(50),
	type_of_training VARCHAR(50)
);

--m(Players):n(Trainings);
CREATE TABLE Goes_To(
	pid INT FOREIGN KEY REFERENCES Player(pid) ON DELETE CASCADE ON UPDATE CASCADE,
	training_id INT FOREIGN KEY REFERENCES Training(training_id) ON DELETE CASCADE ON UPDATE CASCADE,
	tactics VARCHAR(50),
	PRIMARY KEY (training_id, pid)
);

--1(Player):n(medical_tests)
CREATE TABLE Medical_test(
	mid INT PRIMARY KEY NOT NULL,
	player_name VARCHAR(25),
	kg VARCHAR(50),
	type_of_medical_test VARCHAR(50),
);

--m(Players):n(Medical tests);
CREATE TABLE Has_To_Do(
	mid INT FOREIGN KEY REFERENCES Medical_test(mid) ON DELETE CASCADE ON UPDATE CASCADE,
	pid INT FOREIGN KEY REFERENCES Player(pid) ON DELETE CASCADE ON UPDATE CASCADE,
	health_percentage INT,
	PRIMARY KEY (mid, pid)
);

--1(Medical test):1(Physician)
CREATE TABLE Physician(
	physician_id INT PRIMARY KEY NOT NULL,
	mid INT FOREIGN KEY REFERENCES Medical_test(mid) ON DELETE CASCADE ON UPDATE CASCADE,
	name VARCHAR(25),
	kg INT,
	department VARCHAR(50),
	remuneration INT,
	UNIQUE(mid)	
);

CREATE TABLE Special_Guests_Veterans(
	spec_id INT PRIMARY KEY NOT NULL,
	mid INT FOREIGN KEY REFERENCES Match(mid) ON DELETE CASCADE ON UPDATE CASCADE, --@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	player_name VARCHAR(25),
	player_position VARCHAR(50),
	last_team_played VARCHAR(50),
	no_of_titles_earned_during_career INT
);

create table Fan
(
    fid int primary key,
    name varchar(max),
    age int,
    country varchar(max)
)

create table FanOfPlayer --many to many
(
    --fid int references Fan(fid),
    --pid int references Player(pid),
	fid INT FOREIGN KEY REFERENCES Fan(fid) ON DELETE CASCADE ON UPDATE CASCADE, --@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	pid INT FOREIGN KEY REFERENCES Player(pid) ON DELETE CASCADE ON UPDATE CASCADE, --@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	fan_percentage int
	--check(pid >=0 and pid<=10),

	--CONSTRAINT fid FOREIGN KEY(fid) REFERENCES Fan(fid),
	--CONSTRAINT pid FOREIGN KEY(pid) REFERENCES Player(pid),

    primary key (fid, pid)
)