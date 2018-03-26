/*
Deal with the CEO losing his laptop.
*/

EXEC Group3_UpdateComputerStatus 2, 3

/*
Add two computers of your own chosing
*/

DECLARE @firstCompKey int;
DECLARE @secondCompKey int;
EXEC Group3_AddComputer 1, 1, 0, '3/24/2018', '3/24/2018', 4999.00, 32, 1024, 'Radeon Pro Vega 56', 2, 3.2, @computerKey = @firstCompKey OUTPUT;
EXEC Group3_AddComputer 2, 4, 0, '3/24/2018', '3/24/2018', 999.99, 8, 256, 'Intel® UHD Graphics 620', 2, 1.6, @computerKey = @secondCompKey OUTPUT;

/*
Query that shows all available computers/devices- Assign one of the new machines to the CEO
*/

SELECT
	*
FROM Computers
EXEC Group3_AssignComputer @firstCompKey, 0, 1, '3/24/2018';

/*
Return it and assign the other machine (the CEO hated your first choice)
*/

EXEC Group3_ReturnComputer @firstCompKey, '3/24/2018';
EXEC Group3_AssignComputer @secondCompKey, 0, 1, '3/24/2018';
