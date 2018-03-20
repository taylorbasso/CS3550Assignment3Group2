ALTER TABLE Computers
	ADD CONSTRAINT _Group2_ComputerPrice CHECK (ComputerPrice BETWEEN 0 AND 10000)