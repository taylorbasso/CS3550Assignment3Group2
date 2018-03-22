CREATE PROCEDURE Group2_ComputerHistory
	@ComputerID int
AS
	SELECT
		C.ComputerKey,
		C.PurchaseDate,
		C.PurchaseCost,
		OS.ComputerStatus [OldStatus],
		NS.ComputerStatus [NewStatus],
		CSH.StatusDateTime,
		E.EmployeeKey,
		CONCAT(E.FirstName, ' ', E.LastName) [AssignedEmployee]
	FROM
		dbo.Computers C
		LEFT JOIN dbo.Group2_ComputerStatusHistory CSH ON C.ComputerKey = CSH.ComputerKey
		LEFT JOIN dbo.EmployeeComputers EC ON C.ComputerKey = EC.ComputerKey
		LEFT JOIN dbo.Employees E ON EC.EmployeeKey = E.EmployeeKey
		LEFT JOIN dbo.ComputerStatuses OS ON CSH.OldComputerStatusKey = OS.ComputerStatusKey
		LEFT JOIN dbo.ComputerStatuses NS ON CSH.NewComputerStatusKey = NS.ComputerStatusKey
	WHERE
		C.ComputerKey = @ComputerID
