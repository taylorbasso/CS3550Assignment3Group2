--Retire a computer. Make sure the computer is fully depreciated, or do not let it be retired.

CREATE PROCEDURE Group3_RetireComputer
	@computerKey int

AS
	UPDATE dbo.Computers
	SET
		ComputerStatusKey = 5
	WHERE
		ComputerKey = @computerKey