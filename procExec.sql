USE EPAM_Airline

GO

DECLARE @NewTickedId INT
EXEC spCreateTicket @CustomerId = 1, @FlightId = 1, @Seat = '1A', @TicketId = @NewTickedId OUTPUT;

