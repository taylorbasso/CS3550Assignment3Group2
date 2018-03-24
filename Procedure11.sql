--Retire a computer. Make sure the computer is fully depreciated, or do not let it be retired.

CREATE OR ALTER PROCEDURE Group3_RetireComputer
	@computerKey int

AS
	DECLARE @depreciation money,
			@computerOriginalCost money,
			@computerTypeKey int,
			@purchaseDate date

	SELECT
		@computerOriginalCost = PurchaseCost,
		@computerTypeKey = ComputerTypeKey,
		@purchaseDate = PurchaseDate
	FROM Computers
	WHERE ComputerKey = @computerKey

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
