/*Create stored procedures that complete the below tasks. 
You can combine as you feel is appropriate. As a general rule of thumb, you can expect the 
web developer to pass you keys (not the string values). You however cannot expect that they'll
always pass you valid information... Make sure you take this into account as you're designing/coding the following
stored procedures.

Adding new employees. 
Return the key of the newly created employee, or an error message/code if something doesn't work.*/

CREATE OR ALTER PROCEDURE Group3_InsertEmployee
	@FirstName varchar(50),
	@LastName varchar(50)
AS 
	INSERT Employees 
	(
		FirstName, 
		LastName
	) 
	VALUES 
	(
		@FirstName, 
		@FirstName
	)