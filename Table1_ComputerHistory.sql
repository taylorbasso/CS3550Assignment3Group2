/* 
Just deal with the status?

*/

CREATE TABLE Group2_ComputerStatusHistory
(
	ComputerStatusHistoryKey int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ComputerKey int NOT NULL,
	OldComputerStatusKey int NULL,
	NewComputerStatusKey int NOT NULL,
	StatusDateTime datetime NOT NULL DEFAULT GETDATE()
)

ALTER TABLE Group2_ComputerStatusHistory
	ADD CONSTRAINT FK_Group2_ComputerStatusHistoryComputer
	FOREIGN KEY (ComputerKey)
	REFERENCES Computers (ComputerKey)
	
ALTER TABLE Group2_ComputerStatusHistory
	ADD CONSTRAINT FK_Group2_ComputerStatusHistoryOldStatus
	FOREIGN KEY (OldComputerStatusKey)
	REFERENCES ComputerStatuses(ComputerStatusKey)
	
ALTER TABLE Group2_ComputerStatusHistory
	ADD CONSTRAINT FK_Group2_ComputerStatusHistoryNewStatus
	FOREIGN KEY (NewComputerStatusKey)
	REFERENCES ComputerStatuses(ComputerStatusKey)
	
/*

Is this needed?

The EmployeeComputer table should be enough for the history tracking, since each entry should be a single 
assignment

CREATE TABLE Group2_EmployeeComputerHistory
(
	EmployeeComputerHistoryKey int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ComputerKey int NOT NULL,
	OldEmployeeKey int NULL,
	NewEmployeeKey int NOT NULL,
	StatusDateTime datetime NOT NULL DEFAULT GETDATE()
)

ALTER TABLE Group2_EmployeeComputerHistory
	ADD CONSTRAINT FK_Group2_EmployeeComputerHistoryComputer
	FOREIGN KEY (ComputerKey)
	REFERENCES EmployeeComputers (ComputerKey)
	
ALTER TABLE Group2_EmployeeComputerHistory
	ADD CONSTRAINT FK_Group2_EmployeeComputerHistoryOldEmployee
	FOREIGN KEY (OldEmployeeKey)
	REFERENCES EmployeeComputers (EmployeeKey)
	
ALTER TABLE Group2_EmployeeComputerHistory
	ADD CONSTRAINT FK_Group2_EmployeeComputerHistoryNewEmployee
	FOREIGN KEY (NewEmployeeKey)
	REFERENCES EmployeeComputers (EmployeeKey)
	
*/