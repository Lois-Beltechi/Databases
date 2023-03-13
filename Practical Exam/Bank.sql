/*
Tracking operations within a bank

Relatii:
 1:m Customers & Bank accounts
 1:1 Cards & Bank Accounts
 m:n Cards & ATMs cu verbu Transactions

Tabele:

Customers
	[name, date of birth] MAY HAVE MULTIPLE BANK ACC
	1:m to bank accounts
Bank Accounts
	punem customer; [ 1:m Customers & Bank accounts]
	[IBAN code, curr balance, holder, cards assoc. w/ that bank acc]
1:1 cu bank
Cards
	punem unique la foreign key din tabelul curent [1:1 Cards & Bank Accounts]
	[number, cVV code]
ATMs
	[address]

Transactions
	[sum to be withrawned, card,date/time]
	2 foreign key la ATMS si Cards [ m:n Cards & ATMs cu verbu Transactions]

*/
use [test_bank]

GO
IF OBJECT_ID('Transactions', 'U') IS NOT NULL
	DROP TABLE Transactions
IF OBJECT_ID('ATM', 'U') IS NOT NULL
	DROP TABLE ATM
IF OBJECT_ID('Card', 'U') IS NOT NULL
	DROP TABLE Card
IF OBJECT_ID('BankAccount', 'U') IS NOT NULL
	DROP TABLE BankAccount
IF OBJECT_ID('Customer', 'U') IS NOT NULL
	DROP TABLE Customer





create table Customer(
	CustomerID INT Primary KEY,
	Name VARCHAR(100),
	DOB Date
)

create table BankAccount(
		BankAccountID INT Primary KEY,
		IBAN VARCHAR(30),
		CurrentBalance INT,
		Holder INT REFERENCES Customer(CustomerID)
	)

create table Card(
	CardID INT Primary KEY,
	Number VARCHAR(30),
	CVV INT,
	BankAccountID INT REFERENCES BankAccount(BankAccountID), 
	UNIQUE(BankAccountID)
)

create table ATM(
	ATMID INT Primary KEY,
	ADDRESS VARCHAR(30)
)

create table Transactions(
	ATMID INT FOREIGN KEY REFERENCES ATM(ATMID),
	CardID INT FOREIGN KEY REFERENCES Card(CardID),
	TransactionSum INT,
	DT Datetime,
	CONSTRAINT  TransactionID primary key(ATMID, CardID)
)

INSERT INTO ATM values(1, 'Cluj'),(2, 'Bucuresti')
INSERT INTO Customer values(1,'SabinaSefa', '1999-02-02'), (2, 'asdf', '2000-01-01')
INSERT INTO BankAccount values(1,'12345', 100,1), (2, '6789', 150, 2)
INSERT INTO Card values(1,12,665,1), (2,13,667,2)
INSERT INTO Transactions values(1,1,100,'2012-06-18 10:34:09 AM'),(2,2,10,'2012-06-18 09:34:09 AM'),(1,2,102,'2012-06-18 11:34:09 AM'),(2,1,15,'2012-06-18 08:34:09 AM')

--DELETE FROM Transactions

SELECT * FROM Customer
SELECT * FROM BankAccount
SELECT * FROM Card
SELECT * FROM ATM
SELECT * FROM Transactions
--b)
GO
CREATE PROCEDURE DeleteTransactions(@CardID INT)
AS
	IF @CardID IS NULL
	BEGIN
		RAISERROR('No such card', 16, 1)
		RETURN -1
	END;

	DELETE FROM Transactions
	WHERE CardID=@CardID
GO


EXEC DeleteTransactions 2
SELECT * FROM Transactions

--c)
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

--d) function that lists the cards by [Number, CVv]: total transaction sum>2000

GO
create or alter function ListCardsByTransactions(@mai_mare_ca INT)
	returns table
	return

	SELECT Number, CVV FROM Card 
	WHERE CardID IN (
		SELECT T.CardID--, SUM(TransactionSum) AS S 
		FROM Transactions T
		GROUP BY T.CardID
		--HAVING S > 200
		HAVING SUM(T.TransactionSum) > @mai_mare_ca

	)
	
GO


SELECT * FROM  ListCardsByTransactions(113)



