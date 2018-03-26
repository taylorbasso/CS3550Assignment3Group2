CREATE TRIGGER Group2_ComputerStatusHistoryComputerAfterInsert
ON dbo.Computers
AFTER INSERT
AS
BEGIN

	INSERT Group2_ComputerStatusHistory (ComputerKey, NewComputerStatusKey)
	SELECT
		I.ComputerKey,
		I.ComputerStatusKey
	FROM
		inserted I
	
END

CREATE TRIGGER Group2_ComputerStatusHistoryComputerAfterUpdate
ON dbo.Computers
AFTER UPDATE
AS
BEGIN
	
	INSERT Group2_ComputerStatusHistory(ComputerKey, OldComputerStatusKey, NewComputerStatusKey)
	SELECT
		I.ComputerKey,
		D.ComputerStatusKey [OldComputerStatusKey],
		I.ComputerStatusKey [NewComputerStatusKey]
	FROM
		deleted D
		INNER JOIN inserted I ON D.ComputerKey = I.ComputerKey
END

/* 

Is this really needed?
The EmployeeComputers table should be good enough to track assignments.

CREATE TRIGGER Group2_EmployeeComputerHistoryEmployeeComputersAfterInsert
ON EmployeeComputers
AFTER INSERT
AS
BEGIN
	
	INSERT Group2_EmployeeComputerHistory(ComputerKey, NewEmployeeKey)
	SELECT
		I.ComputerKey,
		I.EmployeeKey
	FROM
		inserted I

END
*/

/* 

If needed. This shouldn't be needed, since the only update that should happen is when an assignment
is returned.

Each Employee-computer relationship should get its own row.

CREATE TRIGGER Group2_EmployeeComputerHistoryEmployeeComputersAfterUpdate
ON EmployeeComputers
AFTER INSERT
AS
BEGIN

	INSERT Group2_EmployeeComputerHistory(ComputerKey, OldEmployeeKey, NewEmployeeKey)
	SELECT
		I.ComputerKey,
		D.EmployeeKey [OldEmployeeKey],
		I.EmployeeKey [NewEmployeeKey]
	FROM
		deleted D
		INNER JOIN inserted I ON D.EmployeeComputerHistoryKey = I.EmployeeComputerHistoryKey
		
END
*/