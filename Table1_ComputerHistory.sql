/* 
Decided to rely on the EmployeeComputers table to link up the Computers to the status history

*/

CREATE TABLE Group2_ComputerHistory
(
	ComputerHistoryKey int IDENTITY(1,1) PRIMARY KEY NOT NULL 
	EmployeeComputerKey int NOT NULL,
	OldComputerStatusKey int,
	NewComputerStatusKey int NOT NULL,
	StatusDateTime datetime NOT NULL DEFAULT GETDATE()
)

ALTER TABLE Group2_ComputerHistory
	ADD CONSTRAINT FK_Group2_ComputerHistoryEmployeeComputer
	FOREIGN KEY (EmployeeComputerKey)
	REFERENCES EmployeeComputers (EmployeeComputerKey)
	
ALTER TABLE Group2_ComputerHistory
	ADD CONSTRAINT FK_Group2_ComputerHistoryOldStatus
	FOREIGN KEY (OldComputerStatusKey)
	REFERENCES ComputerStatuses(ComputerStatusKey)
	
ALTER TABLE Group2_ComputerHistory
	ADD CONSTRAINT FK_Group2_ComputerHistoryNewStatus
	FOREIGN KEY (NewComputerStatusKey)
	REFERENCES ComputerStatuses(ComputerStatusKey)
	
