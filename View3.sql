/*Create a view that returns an employee list - 
should include their full name, email address,
their department, the number of computers they have, 
and who their supervisor is. Onlyreturn active employees.*/

CREATE VIEW Group3_Employees
AS
SELECT
	FirstName + ' ' + LastName [FullName],
	Email,
	Department,
	COUNT(EmployeeComputerKey) [Computers]

FROM
	dbo.Employees E
	LEFT JOIN dbo.EmployeeComputers EC
		ON E.EmployeeKey = EC.EmployeeKey
	LEFT JOIN dbo.Departments D
		ON E.DepartmentKey = D.DepartmentKey
GROUP BY
	FirstName,
	LastName,
	Email,
	Department