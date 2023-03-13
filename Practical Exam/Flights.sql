
--drop views
--DROP VIEW Madrid_Passengers;

--drop functions
--DROP FUNCTION list_valid_flights;

--drop tables with foreign key references
DROP TABLE Payments;
DROP TABLE Reservations;

--drop remaining tables
DROP TABLE Flights;
DROP TABLE Passengers;
DROP TABLE Airplanes;

CREATE TABLE Airplanes (
    id INT PRIMARY KEY,
    model_number VARCHAR(255) NOT NULL,
    registration_number VARCHAR(255) UNIQUE NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE Flights (
    id INT PRIMARY KEY,
    flight_number VARCHAR(255) UNIQUE NOT NULL,
    departure_airport VARCHAR(255) NOT NULL,
    destination_airport VARCHAR(255) NOT NULL,
    departure_date_time DATETIME NOT NULL,
    arrival_date_time DATETIME NOT NULL,
    airplane_id INT,
    FOREIGN KEY (airplane_id) REFERENCES Airplanes(id)
);

CREATE TABLE Passengers (
    id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE Reservations (
    id INT PRIMARY KEY,
    passenger_id INT NOT NULL,
    flight_id INT NOT NULL,
    FOREIGN KEY (passenger_id) REFERENCES Passengers(id),
    FOREIGN KEY (flight_id) REFERENCES Flights(id)
);

CREATE TABLE Payments (
    id INT PRIMARY KEY,
    reservation_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date_time DATETIME NOT NULL,
    type VARCHAR(255) NOT NULL,
    FOREIGN KEY (reservation_id) REFERENCES Reservations(id)
);

-- Delete data from Payments table
DELETE FROM Payments;

-- Delete data from Reservations table
DELETE FROM Reservations;

-- Delete data from Flights table
DELETE FROM Flights;

-- Delete data from Airplanes table
DELETE FROM Airplanes;

-- Delete data from Passengers table
DELETE FROM Passengers;

-- Airplanes table
INSERT INTO Airplanes (id, model_number, registration_number, capacity)
VALUES (1, 'Boeing 747', 'N747AA', 400),
       (2, 'Airbus A320', 'N320AC', 180),
       (3, 'Embraer E190', 'N190EE', 110);

-- Flights table
INSERT INTO Flights (id, flight_number, departure_airport, destination_airport, departure_date_time, arrival_date_time, airplane_id)
VALUES (1, 'AA101', 'New York', 'Los Angeles', '2022-01-01 12:00:00', '2022-01-01 15:00:00', 1),
       (2, 'AA102', 'Los Angeles', 'New York', '2022-01-02 12:00:00', '2022-01-02 15:00:00', 2),
       (3, 'AA103', 'New York', 'London', '2022-01-03 12:00:00', '2022-01-03 15:00:00', 3);

-- Passengers table
INSERT INTO Passengers (id, first_name, last_name, email)
VALUES (1, 'John', 'Doe', 'johndoe@example.com'),
       (2, 'Jane', 'Smith', 'janesmith@example.com'),
       (3, 'Bob', 'Johnson', 'bobjohnson@example.com');


-- Reservations table
INSERT INTO Reservations (id, passenger_id, flight_id)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 3, 3);

-- Payments table
INSERT INTO Payments (id, reservation_id, amount, payment_date_time, type)
VALUES (1, 1, 500.00, '2022-01-01 12:00:00', 'card'),
       (2, 2, 400.00, '2022-01-02 12:00:00', 'cash'),
       (3, 3, 300.00, '2022-01-03 12:00:00', 'card');

	   -- Airplanes table
SELECT * FROM Airplanes;

-- Flights table
SELECT * FROM Flights;

-- Passengers table
SELECT * FROM Passengers;

-- Reservations table
SELECT * FROM Reservations;

-- Payments table
SELECT * FROM Payments;

-----------------------

-- Flights table
SELECT * FROM Flights;


-- Reservations table
SELECT * FROM Reservations;


-- Payments table
SELECT * FROM Payments;


GO
create or alter function list_valid_flights (@start_time DATETIME, @end_time DATETIME, @min_reservations INT)
RETURNS TABLE
AS
RETURN
    SELECT Flights.flight_number, COUNT(*) as valid_reservations
    FROM Flights
    JOIN Reservations ON Flights.id = Reservations.flight_id
    JOIN Payments ON Reservations.id = Payments.reservation_id
    WHERE Flights.departure_date_time BETWEEN @start_time AND @end_time
    GROUP BY Flights.flight_number
    HAVING COUNT(*) > @min_reservations




GO
SELECT * FROM list_valid_flights('2022-01-01 12:00:00', '2022-01-03 12:00:00', 0)
