CREATE FUNCTION Group2_CalculateDepreciation
(
	@ComputerTypeKey int,
	@ComputerOriginalCost money,
	@PurchaseDate date
)
RETURNS money -- Amount Depreciated
AS
BEGIN
	DECLARE @Depreciation int = 48
	IF @ComputerTypeKey = 1
	BEGIN
		SET @Depreciation = 36
	END
	
	DECLARE @Months decimal = DATEDIFF(MONTH, @PurchaseDate, GETDATE())
	
	RETURN (@Months / @Depreciation) * @ComputerOriginalCost
END