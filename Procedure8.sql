/*
Create stored procedures that complete the below tasks. You can combine as you feel is appropriate.
As a general rule of thumb,you can expect the web developer to pass you keys (not the string values).
You however cannot expect that they'llalways pass you valid information...
Make sure you take this into account as you're designing/coding the followingstored procedures.

Assign/reassign a computer. Shouldn't allow computers that are in for repair, lost, or retired
to be assigned out.
*/

CREATE OR ALTER PROCEDURE Group3_AssignComputer
	@ComputerKey int,
	@ComputerStatusKey int,
	@EmployeeKey int,
	@Assigned date
AS
	BEGIN
	IF EXISTS (
		SELECT
			ComputerStatusKey,
			ComputerKey
		FROM
			Computers
		WHERE
			ComputerStatusKey < 3 AND
			ComputerKey = @ComputerKey
		)
		BEGIN
			IF EXISTS (
				SELECT
					EmployeeComputerKey
				FROM 
					EmployeeComputers
				WHERE 
					ComputerKey = @ComputerKey AND
					Returned IS NULL
			)
			BEGIN
				RAISERROR('Computer is already assigned', 1, 1);
			END
			ELSE
			BEGIN
				INSERT INTO EmployeeComputers (EmployeeKey, ComputerKey, Assigned)
				VALUES (@EmployeeKey, @ComputerKey, @Assigned)
			END
		END
	END
