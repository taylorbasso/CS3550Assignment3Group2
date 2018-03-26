/* Update the supervisor of an employee or employees. Make sure it is a valid, active supervisor. */
--CREATE TYPE EmployeeTableType AS TABLE 
--(EmployeeKey int NOT NULL)

-- Decided to put the burden of the loop on the front-end developer. Couldn't figure out a good way to
-- use a temporary table.
CREATE PROCEDURE Group2_UpdateSupervisor
	@SupervisorKey int,
	--@Employees EmployeeTableType READONLY,
	@EmployeeKey int,
	@Error nvarchar(255) OUTPUT
AS
BEGIN
	DECLARE @Terminated date

	-- Error checking
	-- Check for valid Supervisor
	IF NOT EXISTS 
	(
		SELECT 
			EmployeeKey
		FROM 
			Employees E
		WHERE 
			EmployeeKey = @SupervisorKey
	)
	BEGIN
		SET @Error = CONCAT('Invalid Supervisor key [', @SupervisorKey, ']: Employee does not exist!')
		RETURN
	END

	-- Check for active Supervisor record
	SELECT 
		@Terminated = E.Terminated
	FROM 
		Employees E
	WHERE 
		E.EmployeeKey = @SupervisorKey

	IF NOT @Terminated is null
	BEGIN
		SET @Error = CONCAT('Invalid Supervisor key [', @SupervisorKey, ']: Inactive Employee!')
		RETURN
	END
	
	-- Check for valid Employee
	IF NOT EXISTS 
	(
		SELECT 
			EmployeeKey
		FROM 
			Employees E
		WHERE 
			EmployeeKey = @EmployeeKey
	)
	BEGIN
		SET @Error = CONCAT('Invalid Employee key [', @EmployeeKey, ']: Employee does not exist!')
		RETURN
	END

	-- Check for active Employee record
	SELECT
		@Terminated = E.Terminated
	FROM
		Employees E
	WHERE
		E.EmployeeKey = @EmployeeKey

	IF NOT @Terminated is null
	BEGIN
		SET @Error = CONCAT('Invalid Employee key [', @EmployeeKey, ']: Inactive employee!')
		RETURN
	END

	-- Now, process it!
	UPDATE Employees
	SET
		SupervisorEmployeeKey = @SupervisorKey
	WHERE
		EmployeeKey = @EmployeeKey
END