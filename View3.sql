/*Create a view that returns an employee list - 
should include their full name, email address,
their department, the number of computers they have, 
and who their supervisor is. Only return active employees.*/

CREATE VIEW Group3_Employees
AS
SELECT
	E.FirstName + ' ' + E.LastName [FullName],
	E.Email,
	Department,
	COUNT(EmployeeComputerKey) [Computers],
	E2.FirstName + ' ' + E2.LastName [SupervisorFullName]


FROM
	dbo.Employees E
	LEFT JOIN dbo.EmployeeComputers EC
		ON E.EmployeeKey = EC.EmployeeKey
	LEFT JOIN dbo.Departments D
		ON E.DepartmentKey = D.DepartmentKey
	INNER JOIN Employees E2
		ON E2.EmployeeKey = E.SupervisorEmployeeKey

WHERE
	E.Terminated IS NULL

GROUP BY
	E.FirstName,
	E.LastName,
	E.Email,
	Department,
	E2.FirstName,
	E2.LastName
