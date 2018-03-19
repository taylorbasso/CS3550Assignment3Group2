CREATE TABLE Group2_ComputerHistory
(
	ComputerKey int NOT NULL,
	OldComputerStatusKey int,
	NewComputerStatusKey int NOT NULL,
	StatusDateTime datetime NOT NULL DEFAULT GETDATE()
)