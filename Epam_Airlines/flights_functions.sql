USE EPAM_Airline

go

create function fnTest(@a int, @b int)
returns int 
as
begin
	return @a + @b
end

go

select dbo.fnTest(1, 2)

go

create function fnIsTicketAvailable(@FlightId int, @Seat varchar(20))
returns bit
as
begin
	declare @res bit 
	if (EXISTS  (SELECT * FROM tblReservation r WHERE r.FlightId = @FlightId AND r.Seat = @Seat AND r.[Status] = 1 ) )
		set @res = 0;
	else
		set @res = 1;
	return @res
end

select * from tblReservation
where dbo.fnIsTicketAvailable(FlightId,Seat) = 0


alter function fnTableView()
returns table
as
return (select * from tblCustomer)

GO

select * from [dbo].[fnTableView]()

Go

create function fnGetLogs(@operation char)
returns @result table(
				Id int not null ,
				FlightIdOld int not null,
				FlightIdNew int not null,
				CustomerIdOld int not null,
				CustomerIdNew int not null,
				InsertTime datetime not null
				)
as
begin
	if (@operation = 'I')
	begin
	 	insert into @result 
		select * from tblLogs where FlightIdOld = 0
	end
	else if (@operation = 'D')
	begin
	 	insert into @result 
		select * from tblLogs where FlightIdNew = 0
	end
	else if (@operation = 'U')
	begin
	 	insert into @result 
		select * from tblLogs where FlightIdOld != 0 and FlightIdNew != 0
	end
	return
	
end 

select * from [dbo].[fnGetLogs]('u')

