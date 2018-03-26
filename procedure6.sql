CREATE OR ALTER PROCEDURE TerminateEmployee
	@EmployeeKey INT,
	@TerminationDate DATE
AS
BEGIN

	UPDATE Employees
	SET Terminated = @TerminationDate
	WHERE EmployeeKey = @EmployeeKey

	IF EXISTS (
		SELECT
			SupervisorEmployeeKey
		FROM Employees
		WHERE SupervisorEmployeeKey = @EmployeeKey
	)
	BEGIN
		DECLARE @currentSupervisor INT;
		SELECT
			@currentSupervisor = SupervisorEmployeeKey
		FROM Employees
		WHERE EmployeeKey = @EmployeeKey;

		UPDATE Employees
		SET SupervisorEmployeeKey = @currentSupervisor
		WHERE SupervisorEmployeeKey = @EmployeeKey;
	END

	SELECT 
		EmployeeComputerKey,
		ComputerKey
	INTO #computersToReturn
	FROM EmployeeComputers
	WHERE EmployeeKey = @EmployeeKey

	WHILE EXISTS (
		SELECT 
			EmployeeComputerKey
		FROM #computersToReturn
	)
	BEGIN
		DECLARE @computerToReturn INT;
		DECLARE @returnedCompKey INT;

		SELECT TOP 1
			@returnedCompKey = EmployeeComputerKey,
			@computerToReturn = ComputerKey
		FROM #computersToReturn

		EXEC Group3_ReturnComputer @computerToReturn, @TerminationDate

		DELETE FROM #computersToReturn
		WHERE EmployeeComputerKey = @returnedCompKey
	END

END