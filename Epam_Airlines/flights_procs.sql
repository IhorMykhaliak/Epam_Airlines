DROP PROC spCreateTicket

USE EPAM_Airline

GO

CREATE PROC spCreateTicket
	@CustomerId INT,
	@FlightId INT,
	@Seat VARCHAR(20),
	@TicketId INT OUTPUT

AS

BEGIN
	
	DECLARE @Cost NUMERIC(18, 4);

	IF (EXISTS  (SELECT * FROM tblReservation r WHERE r.FlightId = @FlightId AND r.Seat = @Seat AND r.[Status] = 1 ) )
		BEGIN
			RAISERROR ('Seat already booked', 1, 1);
		END
	ELSE
		BEGIN
			SELECT @Cost = Cost FROM tblFlight WHERE Id = @FlightId

			INSERT INTO tblReservation
						(CustomerId, FlightId, Seat, Cost, [Status])
					VALUES 
						(@CustomerId, @FlightId, @Seat, @Cost, 1);

			SET @TicketId = SCOPE_IDENTITY();
		END
END

--DROP PROC spCreateTicket


GO

CREATE PROC spGetAvailableFlights

AS

BEGIN
	
	SELECT 
	f.Id, 
	f.DepartureTime,
	f.ArrivalTime,
	f.Departure,
	f.Destination,
	f.Cost
	FROM tblFlight f
	WHERE f.DepartureTime > GETDATE();

END







