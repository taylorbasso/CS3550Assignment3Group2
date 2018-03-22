/*
Create stored procedures that complete the below tasks. You can combine as you feel is appropriate.
As a general rule of thumb,you can expect the web developer to pass you keys (not the string values).
You however cannot expect that they'llalways pass you valid information... Make sure you take this
into account as you're designing/coding the followingstored procedures.

Creating a new department.
Return the key of the newly created department or an error message/code if something doesn't work
Also, don't allow duplicate department names...
*/
CREATE PROCEDURE Group3_CreateDepartment
	@DepartmentKey_var int OUTPUT,
	@Department_var varchar(255)
AS
	BEGIN
		INSERT dbo.Departments(
			Department
			)
		VALUES (
			@Department_var
			)
	END
