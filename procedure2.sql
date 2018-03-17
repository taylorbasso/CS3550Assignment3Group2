/*Create stored procedures that complete the below tasks. 
You can combine as you feel is appropriate. As a general rule of thumb, you can expect the 
web developer to pass you keys (not the string values). You however cannot expect that they'll
always pass you valid information... Make sure you take this into account as you're designing/coding the following
stored procedures.

Adding new employees. 
Return the key of the newly created employee, or an error message/code if something doesn't work.*/

CREATE OR ALTER PROCEDURE Group3_InsertEmployee
	@LastName varchar(25),
	@FirstName varchar(25),
	@Email varchar(50),
	@Hired date,
	@Terminated date,
	@DepartmentKey int,
	@SupervisorEmployeeKey int
AS BEGIN
	INSERT Employees 
	(
		LastName, 
		FirstName,
		Email,
		Hired,
		Terminated,
		DepartmentKey,
		SupervisorEmployeeKey
	) 
	VALUES 
	(
		@LastName, 
		@FirstName,
		@Email,
		@Hired,
		@Terminated,
		@DepartmentKey,
		@SupervisorEmployeeKey
	)
	SELECT SCOPE_IDENTITY() [EmployeeKey]
END

--EXEC Group3_InsertEmployee 'Knight', 'Bob', 'Bob@knight.com', '2018-03-16', NULL, 1, 1
--EXEC Group3_InsertEmployee NULL, 'Bob', 'Bob@knight.com', '2018-03-16', NULL, 1, 1

