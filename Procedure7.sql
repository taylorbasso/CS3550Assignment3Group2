--Create a new computer. Return the key of the newly created computer, or an error message/code.

CREATE OR ALTER PROCEDURE Group3_AddComputer
	@computerTypeKey int,
	@BrandKey int,
	@ComputerStatusKey int,
	@ComputerStatusDate date,
	@PurchaseDate date,
	@PurchaseCost money,
	@MomoryCapacityInGB int,
	@HardDriveCapacityInGB int,
	@VideoCardDescription varchar(255),
	@CPUTypeKey int,
	@CPUClockRateInGHZ decimal,
	@computerKey int OUTPUT

AS
	INSERT dbo.Computers(
		ComputerTypeKey, 
		BrandKey, 
		ComputerStatusKey, 
		ComputerStatusDate,
		PurchaseDate, 
		PurchaseCost, 
		MemoryCapacityInGB, 
		HardDriveCapacityInGB, 
		VideoCardDescription, 
		CPUTypeKey, 
		CPUClockRateInGHZ) 
	VALUES(
		@computerTypeKey, 
		@brandKey, 
		@ComputerStatusKey, 
		@ComputerStatusDate,
		@PurchaseDate, 
		@PurchaseCost, 
		@MomoryCapacityInGB, 
		@HardDriveCapacityInGB, 
		@VideoCardDescription, 
		@CPUTypeKey, 
		@CPUClockRateInGHZ)
	;

	SELECT 
		@computerKey = MAX(ComputerKey)
	FROM dbo.Computers
	;

RETURN