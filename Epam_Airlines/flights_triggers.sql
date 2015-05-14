use EPAM_Airline

go

alter trigger updateCustomer
on tblCustomer
after update
as
begin 
	declare @date datetime
	select @date = BirthDate 
	from inserted

	if (DATEDIFF(yy, @date, GETDATE()) > 100)
		rollback tran 
end

GO 

drop table tblLogs
 
create table tblLogs(
Id int not null identity(1 ,1),
FlightIdOld int not null,
FlightIdNew int not null,
CustomerIdOld int not null,
CustomerIdNew int not null,
InsertTime datetime not null,
constraint PK_tblLogs_Id primary key(Id)
)

GO

alter trigger addLog
on tblReservation
after insert, update, delete
as
begin
	if exists (select * from inserted)
		if exists (select * from deleted)
			begin
				insert into tblLogs(FlightIdOld,FlightIdNew, CustomerIdOld, CustomerIdNew, InsertTime)
				select d.FlightId, i.FlightId, d.CustomerId, i.CustomerId, CURRENT_TIMESTAMP from inserted i, deleted d
			end
		else
		begin 
			insert into tblLogs(FlightIdOld,FlightIdNew, CustomerIdOld, CustomerIdNew, InsertTime)
			select 0, i.FlightId, 0, i.CustomerId, CURRENT_TIMESTAMP from inserted i
		end
	else
	begin	
		insert into tblLogs(FlightIdOld,FlightIdNew, CustomerIdOld, CustomerIdNew, InsertTime)
		select d.FlightId, 0, d.CustomerId, 0, CURRENT_TIMESTAMP from deleted d
	end
end

declare @id int
exec spCreateTicket 1,1,'1222',@id output; 

update tblReservation
set CustomerId = 11
where id = 8