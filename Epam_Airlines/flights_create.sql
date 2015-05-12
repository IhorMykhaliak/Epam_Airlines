CREATE DATABASE EPAM_Airline

GO

USE EPAM_Airline

GO

CREATE TABLE tblCustomer
(
	Id INT NOT NULL IDENTITY(1,1),
	FirstName NVARCHAR(255) NOT NULL,
	Surname NVARCHAR(255) NOT NULL,
	BirthDate DATETIME NOT NULL,
	Country NVARCHAR(512) NOT NULL,
	Comment NVARCHAR(max) NULL,
	CONSTRAINT PK_tblCustomer_Id PRIMARY KEY (Id)
);

GO

CREATE TABLE tblFlight
(
	Id INT NOT NULL IDENTITY(1,1),
	DepartureTime DATETIME NOT NULL,
	ArrivalTime DATETIME NOT NULL,
	Departure NVARCHAR(255) NOT NULL,
	Destination NVARCHAR(255) NOT NULL,
	Cost NUMERIC(18, 4) NOT NULL,
	SeatsCount INT NOT NULL,
	CONSTRAINT PK_tblFlight_Id PRIMARY KEY (Id),
	CONSTRAINT CK_tblFlight_SeatsCount CHECK (SeatsCount >= 0 AND SeatsCount <= 300)
);

GO

CREATE TABLE tblReservation
(
	Id INT NOT NULL IDENTITY(1,1),
	Seat VARCHAR(20) NOT NULL,
	CustomerId INT NOT NULL, 
	FlightId INT NOT NULL,
	Cost NUMERIC (18, 4) NOT NULL,
	[Status] INT NOT NULL,
	CONSTRAINT PK_tblReservation_Id PRIMARY KEY(Id),
	CONSTRAINT FK_tblReservation_CustomerId_tblCustomer_Id FOREIGN KEY(CustomerId) REFERENCES tblCustomer(Id),
	CONSTRAINT FK_tblReservation_FlightId_tblFlight_Id FOREIGN KEY(FlightId) REFERENCES tblFlight(Id),
 	CONSTRAINT UQ_tblReservation_Seat_FlightId UNIQUE(Seat, FlightId),
	CONSTRAINT CK_tblReservation_Status CHECK ([Status] = 1 OR [Status] = 2)
);

