/*
Your compliance officer is adamant that certain safegaurds are installed in the database.
Consider the following:

Do not let anyone delete a computer record. Can't happen! We have to prove that no
equipment is being purchasedand removed from our systems to sell privately. Instead
of a delete, the computer should be retired, ormade available (depending on its depreciation status).
*/

CREATE TRIGGER Group3_DontSell
ON dbo.ComputerStatuses
INSTEAD OF DELETE
AS
	BEGIN
		IF ComputerStatus < 5
		THEN
				 UPDATE ComputerStatuses SET ComputerStatus = 2
		ELSE
			UPDATE ComputerStatuses SET ComputerStatus = 5
	END
