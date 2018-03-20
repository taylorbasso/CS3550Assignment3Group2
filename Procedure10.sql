--Return a computer

CREATE PROCEDURE Group3_ReturnComputer
	@computerKey int,
	@returned date

AS
	UPDATE dbo.EmployeeComputers
	SET
		Returned = @returned
	WHERE
		ComputerKey = @computerKey
