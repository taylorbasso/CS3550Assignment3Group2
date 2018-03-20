--Create a new computer. Return the key of the newly created computer, or an error message/code.

CREATE PROCEDURE Group3_AddComputer
	@computerKey int OUTPUT,
	@computerTypeKey int,
	@BrandKey int,
	@ComputerStatusKey int,
	@PurchaseDate date,
	@PurchaseCost money,
	@MomoryCapacityInGB int,
	@HardDriveCapacityInGB int,
	@VideoCardDescription varchar(255),
	@CPUTypeKey int,
	@CPUClockRateInGHZ decimal

AS
	INSERT dbo.Computers(
		ComputerKey, 
		ComputerTypeKey, 
		BrandKey, 
		ComputerStatusKey, 
		PurchaseDate, 
		PurchaseCost, 
		MemoryCapacityInGB, 
		HardDriveCapacityInGB, 
		VideoCardDescription, 
		CPUTypeKey, 
		CPUClockRateInGHZ) 
	VALUES(
		@computerKey, 
		@computerTypeKey, 
		@brandKey, 
		@ComputerStatusKey, 
		@PurchaseDate, 
		@PurchaseCost, 
		@MomoryCapacityInGB, 
		@HardDriveCapacityInGB, 
		@VideoCardDescription, 
		@CPUTypeKey, 
		@CPUClockRateInGHZ)

RETURN @computerKey