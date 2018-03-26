/* Create stored procedures that complete the below tasks. You can combine as
 you feel is appropriate. As a general rule of thumb, you can expect the web developer
  to pass you keys (not the string values). You however cannot expect that they'll
  always pass you valid information... Make sure you take this into account as you're
   designing/coding the following stored procedures.

Change the status of a computer (lost computers, in for repairs, etc.) */

-- NOTE: I wonder if this procedure will need to update EmployeeComputers as well... 
-- Leaving it for now, might have to change later.

CREATE OR ALTER PROCEDURE Group3_UpdateComputerStatus
	@ComputerKey int,
	@ComputerStatus int
AS BEGIN
	UPDATE 
		Computers 
	SET 
		ComputerStatusKey=@ComputerStatus,
		ComputerStatusDate=GETDATE()
	WHERE
		ComputerKey=@ComputerKey
END

--EXEC dbo.Group3_UpdateComputerStatus 1, 0;