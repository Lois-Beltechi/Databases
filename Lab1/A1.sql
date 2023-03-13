-- use database da
USE [HandballChampionship];
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

 winter VARCHAR(80) UNIQUE,
autumn VARCHAR(70) UNIQUE,
summer VARCHAR(60) UNIQUE,
spring VARCHAR(100) UNIQUE
)


CREATE TABLE Handball_Championship
(hid INT PRIMARY KEY NOT NULL,
 season_id INT FOREIGN KEY REFERENCES Season(season_id) ON DELETE CASCADE ON UPDATE CASCADE,
european_handball_championship VARCHAR(80),
world_handball_championship VARCHAR(70),
african_handball_championship VARCHAR(60),
ehl_champions_league VARCHAR(100)
)

CREATE TABLE Team
(tid INT PRIMARY KEY NOT NULL,
csm_bucuresti VARCHAR(80) UNIQUE,
fc_valcea VARCHAR(70) UNIQUE,
fc_bihor VARCHAR(60) UNIQUE,
gyor VARCHAR(100) UNIQUE,
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
CREATE TABLE Player(
	pid INT PRIMARY KEY NOT NULL,
	name VARCHAR(25) NOT NULL,
	kg VARCHAR(50) NOT NULL,
	position VARCHAR(50) UNIQUE,
);


--1 team - m coach
CREATE TABLE Coach(
	cid INT PRIMARY KEY NOT NULL,

	mid INT FOREIGN KEY REFERENCES Match(mid) ON DELETE CASCADE ON UPDATE CASCADE, -- Coach 1 : Matches (m)
	pid INT FOREIGN KEY REFERENCES Player(pid) ON DELETE CASCADE ON UPDATE CASCADE,--1(coach):n(players)

	coach_name VARCHAR(50),
	coach_phone_number VARCHAR(10) UNIQUE,
	coach_kg VARCHAR(50),
	coach_salary INT
);

--m(Coach):n(Teams);
CREATE TABLE Have(
	cid INT FOREIGN KEY REFERENCES Coach(cid) ON DELETE CASCADE ON UPDATE CASCADE,
	tid INT FOREIGN KEY REFERENCES Team(tid) ON DELETE CASCADE ON UPDATE CASCADE,
	tactics VARCHAR(50),
	PRIMARY KEY (cid, tid)
);

--1(Player):1(Contract) 
CREATE TABLE Contract(
	contract_id INT PRIMARY KEY NOT NULL,
	pid INT FOREIGN KEY REFERENCES Player(pid) ON DELETE CASCADE ON UPDATE CASCADE,
	name VARCHAR(25) NOT NULL,
	date VARCHAR(50) NOT NULL,
	remuneration VARCHAR(50) NOT NULL,
	UNIQUE(pid)
);

CREATE TABLE Training(
	training_id INT PRIMARY KEY NOT NULL,
	date VARCHAR(25) NOT NULL,
	place VARCHAR(50) NOT NULL,
	type_of_training VARCHAR(50) NOT NULL
);

--m(Players):n(Trainings);
CREATE TABLE Goes_To(
	pid INT FOREIGN KEY REFERENCES Player(pid) ON DELETE CASCADE ON UPDATE CASCADE,
	training_id INT FOREIGN KEY REFERENCES Training(training_id) ON DELETE CASCADE ON UPDATE CASCADE,
	tactics VARCHAR(50) NOT NULL,
	PRIMARY KEY (training_id, pid)
);

--1(Player):n(medical_tests)
CREATE TABLE Medical_test(
	mid INT PRIMARY KEY NOT NULL,
	player_name VARCHAR(25) ,
	kg VARCHAR(50),
	type_of_medical_test VARCHAR(50) UNIQUE,
);

--m(Players):n(Medical tests);
CREATE TABLE Has_To_Do(
	mid INT FOREIGN KEY REFERENCES Medical_test(mid) ON DELETE CASCADE ON UPDATE CASCADE,
	pid INT FOREIGN KEY REFERENCES Player(pid) ON DELETE CASCADE ON UPDATE CASCADE,
	tactics VARCHAR(50),
	PRIMARY KEY (mid, pid)
);

--1(Medical test):1(Physician)
CREATE TABLE Physician(
	physician_id INT PRIMARY KEY NOT NULL,
	mid INT FOREIGN KEY REFERENCES Medical_test(mid) ON DELETE CASCADE ON UPDATE CASCADE,
	name VARCHAR(25) NOT NULL,
	kg VARCHAR(50) NOT NULL,
	department VARCHAR(50) NOT NULL,
	remuneration VARCHAR(50) NOT NULL
	UNIQUE(mid)	
);


