DROP TABLE preparation;
DROP TABLE orders;
DROP TABLE cake;
DROP TABLE cakeTypes;
DROP TABLE chefs;


CREATE TABLE chefs (
  chefID INTEGER PRIMARY KEY,
  name VARCHAR(255),
  gender CHAR(1),
  dob DATE
);

CREATE TABLE cakeTypes (
  cakeTypeId INTEGER PRIMARY KEY,
  name VARCHAR(255),
  description VARCHAR(255)
);

CREATE TABLE cake (
  cakeID INTEGER PRIMARY KEY,
  name VARCHAR(255),
  shape VARCHAR(255),
  weight INTEGER,
  price DECIMAL(10,2),
  cakeTypeId INTEGER,
  FOREIGN KEY (cakeTypeId) REFERENCES cakeTypes (cakeTypeId)
);

CREATE TABLE orders (
  orderdID INTEGER,
  cakeID INTEGER references cake(cakeID),
  numberOfPieces INTEGER,
  PRIMARY KEY (orderdID,cakeID),
  FOREIGN KEY (cakeID) REFERENCES cake (cakeID)
);

CREATE TABLE preparation (
  chefID INTEGER,
  cakeID INTEGER,
  PRIMARY KEY (chefID,cakeID),
  FOREIGN KEY (chefID) REFERENCES chefs (chefID),
  FOREIGN KEY (cakeID) REFERENCES cake (cakeID)
);

INSERT INTO chefs (chefID, name, gender, dob)
VALUES (1, 'John', 'M', '1980-01-01'),
       (2, 'Sue', 'F', '1985-03-15'),
       (3, 'Mike', 'M', '1990-07-20'),
       (4, 'Emily', 'F', '1995-05-10'),
       (5, 'Sam', 'M', '2000-09-01');

INSERT INTO cakeTypes (cakeTypeId, name, description)
VALUES (1, 'Chocolate', 'Chocolate cake with chocolate frosting'),
       (2, 'Vanilla', 'Vanilla cake with vanilla buttercream frosting'),
       (3, 'Red Velvet', 'Red velvet cake with cream cheese frosting'),
       (4, 'Lemon', 'Lemon cake with lemon buttercream frosting'),
       (5, 'Carrot', 'Carrot cake with cream cheese frosting');

INSERT INTO cake (cakeID, name, shape, weight, price, cakeTypeId)
VALUES (1, 'Birthday Cake', 'Round', 4, 25.00, 1),
       (2, 'Wedding Cake', 'Tiered', 10, 100.00, 2),
       (3, 'Anniversary Cake', 'Round', 6, 50.00, 3),
       (4, 'Graduation Cake', 'Sheet', 8, 75.00, 4),
       (5, 'Baby Shower Cake', 'Round', 3, 20.00, 5);

INSERT INTO orders (orderdID, cakeID, numberOfPieces)
VALUES (1, 1, 12),
       (2, 2, 100),
       (3, 3, 50),
       (4, 4, 75),
       (5, 5, 25);

INSERT INTO preparation (chefID, cakeID)
VALUES (1, 1),
		(1, 2),
		(1, 3),
		(1, 4),
		(1, 5),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5);


DELETE FROM preparation;
DELETE FROM orders;
DELETE FROM cake;
DELETE FROM cakeTypes;
DELETE FROM chefs;

SELECT * FROM chefs;
SELECT * FROM cakeTypes;
SELECT * FROM cake;
SELECT * FROM orders;
SELECT * FROM preparation;

--b)
GO
CREATE or alter PROCEDURE addRecordToList (@orderID INT, @cakeID INT, @NoOfPieces INT)
AS
	IF exists (SELECT * From  orders where @orderID=orderdID and @NoOfPieces=numberOfPieces)
	BEGIN
		RAISERROR('Records already in the table', 16, 1)
		RETURN -1
	END;

	INSERT INTO orders VALUES (@orderID,@cakeID,@NoOfPieces)
GO

exec addRecordToList 1,2,5

--c)
	GO
create or alter function specializedChefs()
	returns table
	return

	SELECT * FROM chefs C
	WHERE 
	NOT EXISTS
    (SELECT cakeID  FROM cake -- n-o sa fie niciuna la card1
    EXCEPT
    SELECT cakeID FROM preparation p
    WHERE p.chefID = C.chefID
	)
	
GO
SELECT * FROM  specializedChefs()
/*Chefs:
	chefID primary key
	name
	gender
	dob
cake:	
	cakeID primary key
	name
	shape
	weight
	price
	cakeTypeId foreign key

cakeTypes:
	cakeTypeId primary key
	name
	description
	

Orders:
	orderdID
	cakeID foriegn key
	numberOfPieces
	primary key(orderdID,cakeID)

preparation
	chefID foreign key
	cakeID foreign key
	primary key(chefID,cakeID)

b)order id, cake name, ordered pieces
c) names of chefs specialized in all cakes*/