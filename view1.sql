/* - Create a view that shows all available computers (those that are new or available for 
	reassignment).  Include all the computer specs, brand, etc. and, if applicable, the last person
	who was assigned the machine (just in case you have any questions).  This list will
	be used to determine what computer to assign out. */

DROP VIEW IF EXISTS AvailableComputers;
CREATE VIEW [AvailableComputers] AS
	SELECT
		B.Brand, 
		CT.ComputerType,
		CPU.CPUType, 
		C.CPUClockRateInGHZ,
		C.MemoryCapacityInGB [Memory GB],
		C.HardDriveCapacityinGB,
		C.VideoCardDescription,
		CS.ComputerStatus,
		CONCAT_WS(' ', E.FirstName, E.LastName) [LastAssignedToEmployee]
	FROM
		Computers C
		INNER JOIN ComputerStatuses CS
			ON CS.ComputerStatusKey=C.ComputerStatusKey
		INNER JOIN CPUTypes CPU
			ON CPU.CPUTypeKey=C.CPUTypeKey
		INNER JOIN ComputerTypes CT
			ON CT.ComputerTypeKey=C.ComputerTypeKey
		INNER JOIN Brands B
			ON B.BrandKey=C.BrandKey
		LEFT JOIN EmployeeComputers EC
			ON EC.ComputerKey=C.ComputerKey
		LEFT JOIN Employees E
			ON E.EmployeeKey=EC.EmployeeKey
	WHERE
		CS.ComputerStatus IN ('New', 'Available');

--SELECT * FROM AvailableComputers;
