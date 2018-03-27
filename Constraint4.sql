/*
Your compliance officer is adamant that certain safegaurds are installed in the database.
Consider the following:

Do not let anyone delete a computer record. Can't happen! We have to prove that no
equipment is being purchased and removed from our systems to sell privately. Instead
of a delete, the computer should be retired, or made available
*/

CREATE TRIGGER Group3_DontSell
ON dbo.Computers
INSTEAD OF DELETE
AS
	BEGIN
		SELECT
			ComputerStatusKey
		FROM
			Computers
		IF ComputerStatusKey < 5
			BEGIN
				UPDATE ComputerStatuses SET ComputerStatus = 2
			END
		ELSE
			BEGIN
				UPDATE ComputerStatuses SET ComputerStatus = 5
			END
	END
