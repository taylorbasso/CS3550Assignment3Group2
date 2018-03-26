/*
Create stored procedures that complete the below tasks. You can combine as you feel is appropriate.
As a general rule of thumb,you can expect the web developer to pass you keys (not the string values).
You however cannot expect that they'llalways pass you valid information...
Make sure you take this into account as you're designing/coding the followingstored procedures.
*/

CREATE PROCEDURE Group3_UpdateEmployee
	@EmployeeKey int,
	@LastName varchar(25),
	@FirstName varchar(25),
	@Email varchar(50),
	@Hired date,
	@Terminated date,
	@DepartmentKey int,
	@SuperVisorEmployeeKey int
AS
	BEGIN
		UPDATE
			DBO.Employees
		SET
		  LastName=@LastName,
		  FirstName=@FirstName,
		  Email=@Email,
		  Hired=@Hired,
		  Terminated=@Terminated,
		  DepartmentKey=@DepartmentKey,
		  SuperVisorEmployeeKey=@SuperVisorEmployeeKey
		WHERE
			EmployeeKey=@EmployeeKey
	END
