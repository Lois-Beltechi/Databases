use [WeeklyPoetry]
go

drop table PoemSubmitToComp
drop table UserVotesPoem
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
	userId int foreign key references Users(UserID),
	name varchar(30),
	yearr int,
	place int,
	contestName varchar(50)
)

create table Competitions(
	competitionID int primary key,
	yearr int,
	weekk int,
	topic varchar(50)
)

create table Poems(
	poemID int primary key,
	userID int foreign key references Users(userID),
	--competitionID int references Competitions(competitionID),
	title varchar(20),
	text varchar(100)
)

create table PoemSubmitToComp(
	poemID int references Poems(poemID),
	competitionID int references Competitions(competitionID),
	primary key(poemID, competitionID),
	votes int
)



create table UserVotesPoem(
	userID int foreign key references Users(userID),
	poemID int references Poems(poemID),
	primary key(userID, poemID),
	vote int
)


insert into Users values (1,'a','aa',2000)
insert into Competitions  values (2,2001,1,'a')
insert into Poems values (1,1,'a','a')
insert into PoemSubmitToComp values (1,1,10)


--2
create or alter proc uspUpdatePoemsSubm(@P varchar(50))
as

declare @UserID int
select @UserID = (select userID from Users where userID = @UserID and penName=@P)

if not exists (select * from Users where penName=@P)
begin 
raiserror('invalid Pen name',16,1)
end

declare @PoemID int
select @PoemID = (select poemID from Poems where poemID = @PoemID)


delete from PoemSubmitToComp
where @PoemID=poemID

delete from Poems
where userID=@UserID

exec uspUpdatePoemsSubm 'a'

insert into Users values (2, 'a', 'c', 2002)
insert into Poems values (5,2,'b','b')
insert into Poems values (6,2,'b','c')
insert into PoemSubmitToComp values (4,1,10)
insert into PoemSubmitToComp values (5,2,10)
insert into PoemSubmitToComp values (6,2,10)

select * from PoemSubmitToComp


--3.
create or alter proc vShowC
as
	select yearr, weekk, topic 
	from Competitions c
	where c.competitionID in
		(select p.poemID
			from Poems p INNER JOIN UserVotesPoem u ON u.poemID=p.poemID
			group by c.competitionID
			having count(*)>2 
		)
	
go


--4
create or alter function ufFilterComp(@P int)
returns table
return

select yearr,weekk
from Competitions
where competitionID in
(
select competitionID
from PoemSubmitToComp
group by competitionID
having count(*)>@P
)

select * from ufFilterComp(1)
