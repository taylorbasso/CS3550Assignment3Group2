CREATE VIEW RepairList AS
SELECT
	e.FirstName,
	e.LastName,
	e.Email,
	DATEDIFF(DAY,c.ComputerStatusDate,GETDATE()) AS DaysInForRepair,
	ct.ComputerType,
	b.Brand,
	c.MemoryCapacityInGB,
	c.HardDriveCapacityinGB,
	c.VideoCardDescription,
	cput.CPUType,
	c.CPUClockRateInGHZ
FROM Computers c
	LEFT JOIN ComputerStatuses cs ON
		c.ComputerStatusKey = cs.ComputerStatusKey
	LEFT JOIN EmployeeComputers ec ON
		c.ComputerKey = ec.ComputerKey
	LEFT JOIN Employees e ON
		ec.EmployeeKey = e.EmployeeKey
	LEFT JOIN ComputerTypes ct ON
		c.ComputerTypeKey = ct.ComputerTypeKey
	LEFT JOIN Brands b ON
		c.BrandKey = b.BrandKey
	LEFT JOIN CPUTypes cput ON
		c.CPUTypeKey = cput.CPUTypeKey
WHERE cs.ComputerStatus = 'In for Repairs'