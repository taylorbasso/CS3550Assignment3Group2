IF OBJECT_ID(N'ComputersOfBrand', N'IF') IS NOT NULL
    DROP FUNCTION ComputersOfBrand;
GO
CREATE FUNCTION ComputersOfBrand
(
	@BrandKey INT
)
RETURNS TABLE
AS
RETURN
(
	SELECT
		ct.ComputerType,
		b.Brand,
		c.MemoryCapacityInGB,
		c.HardDriveCapacityinGB,
		c.VideoCardDescription,
		cput.CPUType,
		c.CPUClockRateInGHZ,
		cs.ComputerStatus,
		e.FirstName AS AssignedEmployeeFirstName,
		e.LastName AS AssignedEmployeeLastName,
		ec.Assigned AS AssignedDate
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
	WHERE c.BrandKey = @BrandKey
)
;
GO