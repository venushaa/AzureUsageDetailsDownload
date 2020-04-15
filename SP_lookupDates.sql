CREATE Procedure [dbo].[lookupDatesSP] @startDate varchar(1000),  @endDate varchar(1000), @interval int AS
DECLARE
@origStartDate varchar (1000) = @startDate,
@origEndDate varchar (1000) = @endDate,
@diff integer = datediff (day, @startDate, @endDate) 

truncate table lookupDates;

while (CONVERT(DATE, (dateadd(day, @interval-1, @startDate ))) <= CONVERT(DATE, @origEndDate ))
BEGIN
	--@startDate=@startDate
	set @endDate =  dateadd(day, @interval-1, @startDate)
	--INSERT INTO TABLE
	Insert into [dbo].[lookupDates] values (CONVERT(DATE, @startDate) , CONVERT(DATE, @endDate) );
	set @startDate =  dateadd(day, 1, @endDate);
END
If (CONVERT(DATE, @endDate)< CONVERT(DATE, @origEndDate))
Begin
	set @startDate = dateadd(day, 1, @endDate)
	set @endDate=@origEndDate

	--INSERT INTO SQL
	Insert into [dbo].[lookupDates] values (CONVERT(DATE, @startDate) , CONVERT(DATE, @endDate) );
END

IF (CONVERT(DATE, (dateadd(day, @interval-1, @origStartDate ))) > CONVERT(DATE, @origEndDate ))
BEGIN
	Insert into [dbo].[lookupDates] values (CONVERT(DATE, @startDate) , CONVERT(DATE, @endDate) );
END
