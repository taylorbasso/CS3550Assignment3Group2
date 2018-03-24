/* 
Create a new Mac Book pro laptop for Major Geek. 
Use whatever specs you can find off the Appleweb page. 
Make sure the laptop gets assigned to Major Geek
*/

DECLARE @newCompKey int;
EXEC Group3_AddComputer 2, 1, 0, '3/24/2018', '3/24/2018', 1799.00, 8, 256, 'Intel Iris Plus Graphics 650', 2, 3.1, @computerKey = @newCompKey OUTPUT;
EXEC Group3_AssignComputer @newCompKey, 0, 3, '3/24/2018';

/* 
Terminate employee #3 (Major Geek) 
*/

--Waiting for procedure 6

/* 
A query using your inline table function to display available apple computers
*/

SELECT
	*
FROM
	ComputersOfBrand(1)

/* 
A query (using inline view or stored procedure) that shows the history of a specific computerin your database.
*/

EXEC Group2_ComputerHistory 1