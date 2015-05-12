USE EPAM_Airline

GO

CREATE VIEW vwTicket
AS
SELECT 
	r.Id, 
	c.Id AS "CustomerId", 
	f.Id AS "FlightId",
	Seat,
	FirstName,
	Surname,
	DepartureTime,
	Departure,
	ArrivalTime,
	Destination,
	r.Cost AS "Cost" 
FROM tblReservation r
LEFT JOIN tblCustomer c ON r.CustomerId = c.Id
LEFT JOIN tblFlight f ON r.FlightId = f.Id

GO

SELECT * FROM vwTicket

--DROP VIEW vwTicket


