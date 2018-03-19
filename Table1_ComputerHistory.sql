CREATE TABLE Group2_ComputerHistory
(
	ComputerHistoryKey int IDENTITY(1,1) PRIMARY KEY NOT NULL 
	ComputerKey int NOT NULL,
	OldComputerStatusKey int,
	NewComputerStatusKey int NOT NULL,
	StatusDateTime datetime NOT NULL DEFAULT GETDATE()
)