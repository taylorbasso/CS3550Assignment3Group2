/*Create a function (or functions) that will convert TB to GB and GB to TB. 
Looking at the database, you can see that hard drive space is stored in GB 
but the developer expects to be able to display TB (and doesn't want to do 
the conversion themselves). They'll also be passing back TB when they manipulate 
computer inventory and you'll need to convert to GB to store.*/
CREATE OR ALTER FUNCTION Group3_GBtoTBConverter
(
	@num1 DECIMAL(18,10)
)
RETURNS DECIMAL(18,10)
AS BEGIN
	RETURN 1.0 * (@num1 / 1024)
END

--SELECT dbo.Group3_GBtoTBConverter(131.12);

CREATE OR ALTER FUNCTION Group3_TBtoGBConverter
(
	@num1 DECIMAL(18,10)
)
RETURNS DECIMAL(18,10)
AS BEGIN
	RETURN 1.0 * (@num1 * 1024)
END

--SELECT dbo.Group3_TBtoGBConverter(2.11);