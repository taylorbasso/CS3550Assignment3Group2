--Retire a computer. Make sure the computer is fully depreciated, or do not let it be retired.

CREATE PROCEDURE Group3_RetireComputer
	@computerKey int,
	@computerOriginalCost money,
	@computerTypeKey int,
	@purchaseDate date,
	@depreciation int

AS
	SET
		@depreciation = @computerOriginalCost - dbo.Group2_CalculateDepreciation (@computerTypeKey, @computerOriginalCost, @purchaseDate)
	
	UPDATE dbo.Computers
	SET
		ComputerStatusKey = 5,
		ComputerStatusDate = GETDATE()
	WHERE
		ComputerKey = @computerKey
		AND
		@depreciation <= 0
