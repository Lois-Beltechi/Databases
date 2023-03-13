DROP TABLE Buy;
DROP TABLE Found;
DROP TABLE Shoes;
DROP TABLE ShoeModel;
DROP TABLE Women;
DROP TABLE PresentationShop;



CREATE TABLE PresentationShop (
  presentationID INTEGER PRIMARY KEY,
  name VARCHAR(255),
  city VARCHAR(255)
);

CREATE TABLE Women (
  womenID INTEGER PRIMARY KEY,
  name VARCHAR(255),
  maximumAmountSpend INTEGER
);

CREATE TABLE ShoeModel (
  shoeModelID INTEGER PRIMARY KEY,
  name VARCHAR(255),
  season VARCHAR(255)
);

CREATE TABLE Shoes (
  shoeID INTEGER PRIMARY KEY,
  shoeModelID INTEGER FOREIGN KEY REFERENCES ShoeModel(shoeModelID),
  price INTEGER
);


CREATE TABLE Found (
  shoeID INTEGER FOREIGN KEY REFERENCES Shoes(shoeID),
  presentationShopID INTEGER FOREIGN KEY REFERENCES PresentationShop(presentationID),
  availableShoe INTEGER,
  PRIMARY KEY(shoeID, presentationShopID)
);

CREATE TABLE Buy (
  womenID INTEGER FOREIGN KEY REFERENCES Women(womenID),
  shoeID INTEGER FOREIGN KEY REFERENCES Shoes(shoeID),
  numberOfShoes INTEGER,
  amountSpent INTEGER,
  PRIMARY KEY(womenID, shoeID)
);

INSERT INTO PresentationShop (presentationID, name, city)
VALUES (1, 'Shop 1', 'New York'),
       (2, 'Shop 2', 'Los Angeles'),
       (3, 'Shop 3', 'Chicago');

INSERT INTO Women (womenID, name, maximumAmountSpend)
VALUES (1, 'Alice', 200),
       (2, 'Bob', 250),
       (3, 'Eve', 300);

INSERT INTO ShoeModel (shoeModelID, name, season)
VALUES (1, 'Sneakers', 'Spring'),
       (2, 'Boots', 'Winter'),
       (3, 'Sandals', 'Summer');


INSERT INTO Shoes (shoeID, shoeModelID, price)
VALUES (1, 1, 100),
       (2, 2, 150),
       (3, 3, 120);


INSERT INTO Found (shoeID, presentationShopID, availableShoe)
VALUES (1, 1, 10),
	   (1, 2, 10),
       (2, 1, 5),
	   (2, 2, 5),
       (3, 3, 15);

INSERT INTO Buy (womenID, shoeID, numberOfShoes, amountSpent)
VALUES (1, 1, 2, 200),
	   (1, 2, 2, 200),
	   (1, 3, 2, 200),
       (2, 2, 1, 150),
       (3, 3, 3, 360);


SELECT * FROM PresentationShop;
SELECT * FROM Women;
SELECT * FROM ShoeModel;
SELECT * FROM Shoes;
SELECT * FROM Found;
SELECT * FROM Buy;



DELETE FROM Found;
DELETE FROM Buy;
DELETE FROM Shoes;
DELETE FROM ShoeModel;
DELETE FROM Women;
DELETE FROM PresentationShop;






--b)GO
CREATE or alter PROCEDURE addRecordToFound (@shoeID INT, @presentationShopID INT, @availableShoe INT)
AS
	IF @shoeID NOT in (SELECT shoeID From Shoes)
	BEGIN
		RAISERROR('No such shoe', 16, 1)
		RETURN -1
	END;

	IF @presentationShopID NOT in (SELECT presentationID From PresentationShop)
	BEGIN
		RAISERROR('No such presentation shop', 16, 1)
		RETURN -1
	END;

	IF exists (SELECT * From Found where @presentationShopID=presentationShopID and @shoeID=shoeID)
	BEGIN
		RAISERROR('No such presentation shop', 16, 1)
		RETURN -1
	END;

	INSERT INTO Found VALUES (@shoeID,@presentationShopID,@availableShoe)
GO


EXEC addRecordToFound 1,2,1 
SELECT * FROM Found

--c)
GO
create or alter view WomenWhoeBothShoeModel
AS

	SELECT womenID
	FROM Buy b 
	where b.numberOfShoes>=2
	Group by womenID

GO

select * from WomenWhoeBothShoeModel

--d)
GO
create or alter function shoesInPresentationShop(@mai_mare_ca INT)
	returns table
	return

	SELECT *
	FROM Shoes
	WHERE shoeID IN (
		SELECT f.shoeID
		FROM Found f
		GROUP BY shoeID
		HAVING count(*) > @mai_mare_ca

	)
	
GO


SELECT * FROM  shoesInPresentationShop(1)

/*
Shoes:
	shoeID primary key
	shoshoeModelID foreign key
	price	

Shoe model:
	shoeModelID primary key
	name
	season

Presenation Shop:
	presenatationID primary key
	name
	city

Women:
	womenID primary Key
	name
	maximumAmountSpend int

found:
	shoeID foreign key
	presentationShopID foreign key
	availableShoe int
	primary key(shoeID,presentationShopID)

buy:
	womenID foreign key
	shoeID foreign key
	numberOfShoes
	amountSpent
	primary key(womenID,shoeID)
	

m:m shoe-presentation shop

b)
shoe, presenatation shop, number of shoes

c)show the women who both at lest 2 shoes
 from a shoe model

d)-list the shoe that can be found in
at lest t presentation shops
shoe presentation*/
