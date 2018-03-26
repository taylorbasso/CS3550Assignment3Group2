CREATE VIEW Group2_LostStolenComputers
AS
	SELECT
		C.ComputerKey,
		E.EmployeeKey,
		CONCAT(E.FirstName, ' ', E.LastName) [AssignedEmployee],
		C.PurchaseDate,
		C.PurchaseCost,
		dbo.Group2_CalculateDepreciation
		(
			C.ComputerTypeKey, 
			C.PurchaseCost, 
			C.PurchaseDate
		) [Depreciation],
		C.PurchaseCost - dbo.Group2_CalculateDepreciation
		(
			C.ComputerTypeKey, 
			C.PurchaseCost, 
			C.PurchaseDate
		) [Value],
		S.ComputerStatus,
		H.StatusDateTime
	FROM 
		dbo.Computers C
		INNER JOIN dbo.ComputerTypes T ON C.ComputerTypeKey = T.ComputerTypeKey
		INNER JOIN dbo.ComputerStatuses S ON C.ComputerStatusKey = S.ComputerStatusKey
		LEFT JOIN dbo.EmployeeComputers EC ON C.ComputerKey = EC.ComputerKey
		LEFT JOIN dbo.Employees E ON EC.EmployeeKey = E.EmployeeKey
		LEFT JOIN dbo.Group2_ComputerStatusHistory H ON C.ComputerKey = H.ComputerKey
			AND S.ComputerStatusKey = H.NewComputerStatusKey
	WHERE
		S.ComputerStatus IN ('Lost')