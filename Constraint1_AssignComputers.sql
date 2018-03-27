/*No individual can have more than two working desktops or one working laptop assigned to them at any given time.*/

CREATE OR ALTER TRIGGER Group3_employeeComputer
ON dbo.EmployeeComputers
INSTEAD OF INSERT
AS
	BEGIN
		DECLARE @desktopcount INT, @laptopcount INT, @insertedCompType INT
		SELECT
			@desktopcount = COUNT(CASE c.ComputerTypeKey WHEN 1 THEN 1 ELSE NULL END),
			@laptopcount = COUNT(CASE c.ComputerTypeKey WHEN 2 THEN 1 ELSE NULL END)
		FROM
			EmployeeComputers ec
		LEFT JOIN Computers c ON
			ec.ComputerKey = c.ComputerKey
		WHERE
			EmployeeKey = (SELECT EmployeeKey FROM inserted) AND
			c.ComputerStatusKey < 3 AND
			ec.Returned IS NULL

		SELECT
			@insertedCompType = c.ComputerTypeKey
		FROM inserted i
		LEFT JOIN Computers c ON 
			i.ComputerKey = c.ComputerKey

		IF ((@insertedCompType = 1 AND @desktopcount >= 2) OR (@insertedCompType = 2 AND @laptopcount >= 1))
			BEGIN
				RAISERROR('No individual can have more than two working desktops or one working laptop assigned to them at any given time.', 1, 1);
			END

		ELSE
			BEGIN
				INSERT INTO EmployeeComputers (EmployeeKey, ComputerKey, Assigned, Returned)
				SELECT
					EmployeeKey,
					ComputerKey,
					Assigned,
					Returned
				FROM inserted
			END
	END