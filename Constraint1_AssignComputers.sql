/*No individual can have more than two working desktops or one working laptop assigned to them at any given time.*/

CREATE TRIGGER Group3_employeeComputer
ON dbo.EmployeeComputers
INSTEAD OF INSERT
AS
	BEGIN
		SELECT
			EmployeeKey,
			COUNT(*) [Computers]
		FROM
			EmployeeComputers
		GROUP BY
			EmployeeKey
		HAVING
			COUNT(*) < 3

		IF (COUNT(*) > 2)
			BEGIN
				BREAK
			END

		ELSE
			BEGIN
				--Insert call to Assign Computer Call
			END
	END