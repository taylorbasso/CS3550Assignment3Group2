/*Create the department 'Business Intelligence'
Add two valid employee, both part of Business Intelligence
Try to add an employee, passing in a department that doesn't exist
Try to add an employee, passing in a supervisor that is no longer active (what should this do?)*/

/*1.*/

DECLARE @CaptureOutput int
EXEC Group3_CreateDepartment @Department_var = 'Business Intelligence', @DepartmentKey_var = @CaptureOutput

/*SELECT	
	*
FROM 
	dbo.Departments
*/

/*2.*/

EXEC Group3_InsertEmployee @LastName = 'Sellars', @FirstName = 'Peter', @Email = 'peter.sellars@example.com', @Hired = '1/19/2018', @Terminated = NULL, @DepartmentKey = 5, @SupervisorEmployeeKey = 1
EXEC Group3_InsertEmployee @LastName = 'Sellars', @FirstName = 'John', @Email = 'john.sellars@example.com', @Hired = '1/12/2018', @Terminated = NULL, @DepartmentKey = 5, @SupervisorEmployeeKey = 1

/*SELECT	
	*
FROM
	dbo.Employees*/


/*3.*/

EXEC Group3_InsertEmployee @LastName = 'Reaper', @FirstName = 'Grim', @Email = 'fatherOfDeath@example.com', @Hired = '1/12/2018', @Terminated = NULL, @DepartmentKey = 6, @SupervisorEmployeeKey = 1
	--Should fail because the department has not yet been created.

/*4.*/

EXEC Group3_InsertEmployee @LastName = 'Star', @FirstName = 'Super', @Email = 'smashMouth@example.com', @Hired = '1/12/2018', @Terminated = NULL, @DepartmentKey = 5, @SupervisorEmployeeKey = 2
	--Should fail because the supervisor is no longer active.