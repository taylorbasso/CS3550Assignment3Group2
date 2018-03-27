/* Drop the tables! */
/*
DROP TABLE Group2_EmployeeComputers
;

DROP TABLE Group2_ComputerStatusHistory
;

DROP TABLE Group2_Computers
;

DROP TABLE Group2_Employees
;

DROP TABLE Group2_Brands
;

DROP TABLE Group2_ComputerTypes
;

DROP TABLE Group2_ComputerStatuses
;

DROP TABLE Group2_CPUTypes
;

DROP TABLE Group2_Departments;

DROP VIEW IF EXISTS Group2_AvailableComputers

DROP VIEW IF EXISTS Group2_RepairList

DROP VIEW IF EXISTS Group2_EmployeesList

DROP FUNCTION IF EXISTS Group2_GBtoTBConverter

DROP FUNCTION IF EXISTS Group2_TBtoGBConverter

DROP FUNCTION IF EXISTS Group2_ComputersOfBrand

*/

/* Create the tables! */

CREATE TABLE Group2_Brands
(
	BrandKey int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Brand varchar(40) NOT NULL,
	Active bit DEFAULT(1) NOT NULL
)

CREATE TABLE Group2_ComputerTypes
(
	ComputerTypeKey int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ComputerType varchar(25) NOT NULL
) 

CREATE TABLE Group2_ComputerStatuses
(
	ComputerStatusKey int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ComputerStatus varchar(50) NOT NULL,
	ActiveStatus bit NOT NULL  --an indicator of if this status means the computer is available or not
)

CREATE TABLE Group2_CPUTypes
(
	CPUTypeKey int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	CPUType varchar(40) NOT NULL
)

CREATE TABLE Group2_Computers
(
	ComputerKey int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ComputerTypeKey int NOT NULL,
	BrandKey int NOT NULL,	
	ComputerStatusKey int NOT NULL DEFAULT(0),
	PurchaseDate date NOT NULL,
	PurchaseCost money NOT NULL,
	MemoryCapacityInGB int NOT NULL,
	HardDriveCapacityinGB int NOT NULL,
	VideoCardDescription varchar (255),
	CPUTypeKey int NOT NULL,
	CPUClockRateInGHZ decimal (6, 4)
)

SET IDENTITY_INSERT Group2_Computers ON
INSERT Group2_Computers (ComputerKey, ComputerTypeKey, BrandKey, ComputerStatusKey, PurchaseDate, PurchaseCost, MemoryCapacityInGB, 
	HardDriveCapacityinGB, VideoCardDescription, CPUTypeKey, CPUClockRateInGHZ) VALUES
	(1, 1, 1, 0, '1/1/2017', 1999.99, 32, 1024, 'Nvidia 1080', 1, 3.5),
	(2, 2, 4, 0, '1/1/2017', 2399.99, 16, 512, 'Nvidia GeForce GT 650M', 1, 2.5)
SET IDENTITY_INSERT Group2_Computers OFF

CREATE TABLE Group2_Departments
(
	DepartmentKey int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Department varchar(255)
)

SET IDENTITY_INSERT Group2_Departments ON
INSERT Group2_Departments (DepartmentKey, Department) VALUES
	(1, 'CEO'),
	(2, 'Human Resources'),
	(3, 'Information Technology'),
	(4, 'Accounting')
SET IDENTITY_INSERT Group2_Departments OFF

CREATE TABLE Group2_Employees
(
	EmployeeKey int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	LastName varchar(25) NOT NULL,
	FirstName varchar(25) NOT NULL,
	Email varchar(50) NOT NULL,
	Hired date NOT NULL,
	Terminated date NULL,
	DepartmentKey int NOT NULL,
	SupervisorEmployeeKey int NOT NULL --CEO/Top of hierarchy should have their own EmployeeKey
)

SET IDENTITY_INSERT Group2_Employees ON
INSERT Group2_Employees (EmployeeKey, LastName, FirstName, Email, Hired, DepartmentKey, SupervisorEmployeeKey) VALUES
	(1, 'Ceo', 'John The', 'JCeo@thiscompany.com', '1/1/2017', 1, 1),
	(2, 'Brother', 'Big', 'BBrother@thiscompany.com', '1/1/2017', 2, 1),
	(3, 'Geek', 'Major', 'MGeek@thiscompany.com', '1/1/2017', 3, 1)
SET IDENTITY_INSERT Group2_Employees OFF


CREATE TABLE Group2_EmployeeComputers
(
	EmployeeComputerKey int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	EmployeeKey int NOT NULL,
	ComputerKey int NOT NULL,
	Assigned date NOT NULL,
	Returned date NULL
)

SET IDENTITY_INSERT Group2_ComputerStatuses ON
	INSERT Group2_ComputerStatuses (ComputerStatusKey, ComputerStatus, ActiveStatus) VALUES 
		(0, 'New', 1),
		(1, 'Assigned', 1),
		(2, 'Available', 1),
		(3, 'Lost', 0),
		(4, 'In for Repairs', 0), 
		(5, 'Retired', 1)
SET IDENTITY_INSERT Group2_ComputerStatuses OFF

SET IDENTITY_INSERT Group2_CPUTypes ON 
INSERT Group2_CPUTypes (CPUTypeKey, CPUType) VALUES 
	(1, 'AMD'), 
	(2, 'Intel'), 
	(3, 'Samsung'), 
	(4, 'Apple'), 
	(5, 'Qualcomm')
SET IDENTITY_INSERT Group2_CPUTypes OFF

SET IDENTITY_INSERT Group2_ComputerTypes ON
INSERT Group2_ComputerTypes (ComputerTypeKey, ComputerType) VALUES 
	(1, 'Desktop'),
	(2, 'Laptop'),
	(3, 'Tablet'),
	(4, 'Phone')
SET IDENTITY_INSERT Group2_ComputerTypes OFF

SET IDENTITY_INSERT Group2_Brands ON
INSERT Group2_Brands (BrandKey, Brand) VALUES
	(1, 'Apple'),
	(2, 'Samsung'),
	(3, 'Sony'),
	(4, 'HP'),
	(5, 'Acer'),
	(6, 'NVidia')
SET IDENTITY_INSERT Group2_Brands OFF

ALTER TABLE Group2_Computers 
	ADD CONSTRAINT FK_ComputerComputerTypes 
	FOREIGN KEY (ComputerTypeKey) 
	REFERENCES Group2_ComputerTypes (ComputerTypeKey)

ALTER TABLE Group2_Computers
	ADD CONSTRAINT FK_ComputerBrands
	FOREIGN KEY (BrandKey) 
	REFERENCES Group2_Brands (BrandKey)

ALTER TABLE Group2_Computers
	ADD CONSTRAINT FK_ComputerComputerStatus
	FOREIGN KEY (ComputerStatusKey) 
	REFERENCES Group2_ComputerStatuses (ComputerStatusKey)

ALTER TABLE Group2_Computers
	ADD CONSTRAINT FK_ComputerCPUType
	FOREIGN KEY (CPUTypeKey) 
	REFERENCES Group2_CPUTypes (CPUTypeKey)

ALTER TABLE Group2_Employees
	ADD CONSTRAINT FK_EmployeeDepartment
	FOREIGN KEY (DepartmentKey)
	REFERENCES Group2_Departments (DepartmentKey)

ALTER TABLE Group2_Employees
	ADD CONSTRAINT FK_EmployeeSupervisor
	FOREIGN KEY (SupervisorEmployeeKey)
	REFERENCES Group2_Employees (EmployeeKey)

ALTER TABLE Group2_EmployeeComputers
	ADD CONSTRAINT FK_EmployeeComputerEmployee
	FOREIGN KEY (EmployeeKey)
	REFERENCES Group2_Employees (EmployeeKey)

ALTER TABLE Group2_EmployeeComputers
	ADD CONSTRAINT FK_EmployeeComputerComputer
	FOREIGN KEY (ComputerKey)
	REFERENCES Group2_Computers (ComputerKey)


/*
 - Design a table to store changes to computer assignments.  You have to track every change of status, starting when a 
	computer is added to the inventory, when it is lost, when it is assigned, reassigned, etc.  You need datetime stamps
	when the change occured.  This will be key to the next three requests.
*/

CREATE TABLE Group2_ComputerStatusHistory
(
	ComputerStatusHistoryKey int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ComputerKey int NOT NULL,
	OldComputerStatusKey int NULL,
	NewComputerStatusKey int NOT NULL,
	StatusDateTime datetime NOT NULL DEFAULT GETDATE()
)

ALTER TABLE Group2_ComputerStatusHistory
	ADD CONSTRAINT FK_Group2_ComputerStatusHistoryComputer
	FOREIGN KEY (ComputerKey)
	REFERENCES Group2_Computers (ComputerKey)
	
ALTER TABLE Group2_ComputerStatusHistory
	ADD CONSTRAINT FK_Group2_ComputerStatusHistoryOldStatus
	FOREIGN KEY (OldComputerStatusKey)
	REFERENCES Group2_ComputerStatuses(ComputerStatusKey)
	
ALTER TABLE Group2_ComputerStatusHistory
	ADD CONSTRAINT FK_Group2_ComputerStatusHistoryNewStatus
	FOREIGN KEY (NewComputerStatusKey)
	REFERENCES Group2_ComputerStatuses(ComputerStatusKey)

GO
/*
Some general rules for this assignment:

 - You can change the table structure if you feel it is necessary (the core structure is sound).  More likely, you'll want to add tables, constraints, columns, etc. to the existing structure.  Any changes you make need to be added to the script you turn in and well documented/commented.
 - Hard Drive size is always displayed in TB
 - Memory size is always displayed in GB
 - If I ask for the employee name, I want to see LastName, FirstName
 - Remember to start all your objests off with a prefix - for this project use "Group" followed by
	your number and an underscore (Group1_YourObjectGoesHere)
 - You can accomplish all the work utilizing the objects/structures we've talked about to date.  If you're not sure where to apply what, have a conversation and ask me for clarification.
 - Your overall goal is to complete the requested tasks and make your database retain good data quality and gracefully handle issues if they come up.


Assignment - you've been assigned to work with a web developer to develop out a computer inventory tracking system.  You'll be working on the data layer, providing interfaces for the web developer to consume with their ASP.NET code.  

You are expected, at a minimum, to complete the following tasks - 

 - Create a view that shows all available computers (those that are new or available for 
	reassignment).  Include all the computer specs, brand, etc. and, if applicable, the last person
	who was assigned the machine (just in case you have any questions).  This list will
	be used to determine what computer to assign out.
*/

CREATE OR ALTER VIEW [Group2_AvailableComputers] AS
	SELECT
		B.Brand, 
		CT.ComputerType,
		CPU.CPUType, 
		C.CPUClockRateInGHZ,
		C.MemoryCapacityInGB [Memory GB],
		C.HardDriveCapacityinGB,
		C.VideoCardDescription,
		CS.ComputerStatus,
		CONCAT(E.LastName, ', ', E.FirstName) [LastAssignedToEmployee]
	FROM
		Group2_Computers C
		INNER JOIN Group2_ComputerStatuses CS
			ON CS.ComputerStatusKey=C.ComputerStatusKey
		INNER JOIN Group2_CPUTypes CPU
			ON CPU.CPUTypeKey=C.CPUTypeKey
		INNER JOIN Group2_ComputerTypes CT
			ON CT.ComputerTypeKey=C.ComputerTypeKey
		INNER JOIN Group2_Brands B
			ON B.BrandKey=C.BrandKey
		LEFT JOIN Group2_EmployeeComputers EC
			ON EC.ComputerKey=C.ComputerKey
		LEFT JOIN Group2_Employees E
			ON E.EmployeeKey=EC.EmployeeKey
	WHERE
		CS.ComputerStatus IN ('New', 'Available');

--SELECT * FROM Group2_AvailableComputers;

GO

/*
 - Create a view that shows all computers that are in for repair.  Include who the 
	computer belongs to, their email address, how long it has been in for repairs, 
	and the associated specs, brand, type, etc.  This list will be used to update those
	users that are waiting on repairs.
	*/
	
CREATE VIEW Group2_RepairList AS
SELECT
	e.FirstName,
	e.LastName,
	e.Email,
	DATEDIFF(DAY,h.StatusDateTime,GETDATE()) AS DaysInForRepair,
	ct.ComputerType,
	b.Brand,
	c.MemoryCapacityInGB,
	c.HardDriveCapacityinGB,
	c.VideoCardDescription,
	cput.CPUType,
	c.CPUClockRateInGHZ
FROM 
	Group2_Computers c
	LEFT JOIN Group2_ComputerStatuses cs ON
		c.ComputerStatusKey = cs.ComputerStatusKey
	LEFT JOIN Group2_ComputerStatusHistory h ON
		c.ComputerKey = h.ComputerKey
		AND cs.ComputerStatusKey = h.NewComputerStatusKey
	LEFT JOIN Group2_EmployeeComputers ec ON
		c.ComputerKey = ec.ComputerKey
	LEFT JOIN Group2_Employees e ON
		ec.EmployeeKey = e.EmployeeKey
	LEFT JOIN Group2_ComputerTypes ct ON
		c.ComputerTypeKey = ct.ComputerTypeKey
	LEFT JOIN Group2_Brands b ON
		c.BrandKey = b.BrandKey
	LEFT JOIN Group2_CPUTypes cput ON
		c.CPUTypeKey = cput.CPUTypeKey
WHERE 
	cs.ComputerStatus = 'In for Repairs'

GO

/*
 - Create a view that returns an employee list - should include their full name, email address, 
	their department, the number of computers they have, and who their supervisor is.  Only
	return active employees.
	*/

CREATE VIEW Group2_EmployeesList
AS
SELECT
	CONCAT(E.LastName, ', ', E.FirstName) [FullName],
	E.Email,
	Department,
	COUNT(EmployeeComputerKey) [Computers],
	CONCAT(E2.LastName, ', ', E.FirstName) [SupervisorFullName]


FROM
	Group2_Employees E
	LEFT JOIN dbo.Group2_EmployeeComputers EC
		ON E.EmployeeKey = EC.EmployeeKey
	LEFT JOIN Group2_Departments D
		ON E.DepartmentKey = D.DepartmentKey
	INNER JOIN Group2_Employees E2
		ON E2.EmployeeKey = E.SupervisorEmployeeKey

WHERE
	E.Terminated IS NULL

GROUP BY
	E.FirstName,
	E.LastName,
	E.Email,
	Department,
	E2.FirstName,
	E2.LastName

GO
/*
 - Create a function (or functions) that will convert TB to GB and GB to TB.  Looking at the database, you can
	see that hard drive space is stored in GB but the developer expects to be able to display TB (and doesn't
	want to do the conversion themselves).  They'll also be passing back TB when they manipulate computer inventory
	and you'll need to convert to GB to store.
*/


CREATE OR ALTER FUNCTION Group2_GBtoTBConverter
(
	@num1 DECIMAL(8,3)
)
RETURNS DECIMAL(8,3)
--Returns decimal for developer
AS BEGIN
	RETURN 1.0 * (@num1 / 1024)
END

GO
--SELECT dbo.Group2_GBtoTBConverter(510);

CREATE OR ALTER FUNCTION Group2_TBtoGBConverter
(
	@num1 DECIMAL(8,3)
)
RETURNS int
--Returns int because database columns are int
AS BEGIN
	--Round up to nearest GB
	RETURN CEILING(1.0 * (@num1 * 1024))
END

GO
/*
 - Create an inline table function that accepts a computer brand (or brand key) and returns available computers of 
	that brand back.  Return the same columns as you did in above computer inventory views.
*/

--IF OBJECT_ID(N'Group2_ComputersOfBrand', N'IF') IS NOT NULL
--    DROP FUNCTION Group2_ComputersOfBrand;
--GO


CREATE OR ALTER FUNCTION Group2_ComputersOfBrand
(
	@BrandKey INT
)
RETURNS TABLE
AS
RETURN
(
	SELECT
		ct.ComputerType,
		b.Brand,
		c.MemoryCapacityInGB,
		c.HardDriveCapacityinGB,
		c.VideoCardDescription,
		cput.CPUType,
		c.CPUClockRateInGHZ,
		cs.ComputerStatus,
		e.FirstName AS AssignedEmployeeFirstName,
		e.LastName AS AssignedEmployeeLastName,
		ec.Assigned AS AssignedDate
	FROM 
		Group2_Computers c
		LEFT JOIN Group2_ComputerStatuses cs ON
			c.ComputerStatusKey = cs.ComputerStatusKey
		LEFT JOIN Group2_EmployeeComputers ec ON
			c.ComputerKey = ec.ComputerKey
		LEFT JOIN Group2_Employees e ON
			ec.EmployeeKey = e.EmployeeKey
		LEFT JOIN Group2_ComputerTypes ct ON
			c.ComputerTypeKey = ct.ComputerTypeKey
		LEFT JOIN Group2_Brands b ON
			c.BrandKey = b.BrandKey
		LEFT JOIN Group2_CPUTypes cput ON
			c.CPUTypeKey = cput.CPUTypeKey
	WHERE c.BrandKey = @BrandKey
)

GO

/*
 - The web developer decides that the data layer is going to have to manage the audit logging of changes to computer statuses.
	Design the appropriate triggers to accomplish this, inserting data into the table you created above. 
*/

CREATE OR ALTER TRIGGER Group2_ComputerStatusHistoryComputerAfterInsert
ON Group2_Computers
AFTER INSERT
AS
BEGIN

	INSERT Group2_ComputerStatusHistory (ComputerKey, NewComputerStatusKey)
	SELECT
		I.ComputerKey,
		I.ComputerStatusKey
	FROM
		inserted I
	
END

GO

CREATE OR ALTER TRIGGER Group2_ComputerStatusHistoryComputerAfterUpdate
ON Group2_Computers
AFTER UPDATE
AS
BEGIN
	
	INSERT Group2_ComputerStatusHistory(ComputerKey, OldComputerStatusKey, NewComputerStatusKey)
	SELECT
		I.ComputerKey,
		D.ComputerStatusKey [OldComputerStatusKey],
		I.ComputerStatusKey [NewComputerStatusKey]
	FROM
		deleted D
		INNER JOIN inserted I ON D.ComputerKey = I.ComputerKey
END

GO

/*
 - Create a view that shows all stolen/lost computers.  Include who the computer belongs to, when it
	was purchased, when it was lost, and amount depreciated, and how much is left.  To calculate this, 
	we will assume a 36 month depreciation for desktops, 48 months for everything else (i.e each month we use up 1/36th or 1/48th 
	of the original cost).  You need to see how many months remain and multiple this by the original cost
	of the computer.  A computer that costs 1800 will depreciate at $50 a month.  A computer lost after
	13 months would have depreciated $650 and would still be worth $1150 (show these two values).  Maybe a function
	to compute depreciation?
*/

CREATE OR ALTER VIEW Group2_LostStolenComputers
AS
	SELECT
		C.ComputerKey,
		E.EmployeeKey,
		CONCAT(E.FirstName, ' ', E.LastName) [AssignedEmployee],
		C.PurchaseDate,
		C.PurchaseCost,
		dbo.Group2_CalculateDepreciation
		(
			C.ComputerTypeKey, 
			C.PurchaseCost, 
			C.PurchaseDate
		) [Depreciation],
		C.PurchaseCost - dbo.Group2_CalculateDepreciation
		(
			C.ComputerTypeKey, 
			C.PurchaseCost, 
			C.PurchaseDate
		) [Value],
		S.ComputerStatus,
		H.StatusDateTime
	FROM 
		Group2_Computers C
		INNER JOIN Group2_ComputerTypes T ON C.ComputerTypeKey = T.ComputerTypeKey
		INNER JOIN Group2_ComputerStatuses S ON C.ComputerStatusKey = S.ComputerStatusKey
		LEFT JOIN Group2_EmployeeComputers EC ON C.ComputerKey = EC.ComputerKey
		LEFT JOIN Group2_Employees E ON EC.EmployeeKey = E.EmployeeKey
		LEFT JOIN Group2_ComputerStatusHistory H ON C.ComputerKey = H.ComputerKey
			AND S.ComputerStatusKey = H.NewComputerStatusKey
	WHERE
		S.ComputerStatus IN ('Lost')

GO

/*
 - Create a stored procedure/inline table function that shows the history of a computer - starting with a record for when 
	it was purchased all the way to when it	is retired or lost.  
	Include the computer information you did above, and where applicable the assigned employee name and 
	employee key.
*/

CREATE OR ALTER PROCEDURE Group2_ComputerHistory
	@ComputerID int
AS
	SELECT
		C.ComputerKey,
		C.PurchaseDate,
		C.PurchaseCost,
		OS.ComputerStatus [OldStatus],
		NS.ComputerStatus [NewStatus],
		CSH.StatusDateTime,
		E.EmployeeKey,
		CONCAT(E.LastName, ', ', E.FirstName) [AssignedEmployee]
	FROM
		Group2_Computers C
		LEFT JOIN Group2_ComputerStatusHistory CSH ON C.ComputerKey = CSH.ComputerKey
		LEFT JOIN Group2_EmployeeComputers EC ON C.ComputerKey = EC.ComputerKey
		LEFT JOIN Group2_Employees E ON EC.EmployeeKey = E.EmployeeKey
		LEFT JOIN Group2_ComputerStatuses OS ON CSH.OldComputerStatusKey = OS.ComputerStatusKey
		LEFT JOIN Group2_ComputerStatuses NS ON CSH.NewComputerStatusKey = NS.ComputerStatusKey
	WHERE
		C.ComputerKey = @ComputerID
GO

/*
Create stored procedures that complete the below tasks.  You can combine as you feel is appropriate.  As a general rule of thumb,
	you can expect the web developer to pass you keys (not the string values).  You however cannot expect that they'll 
	always pass you valid information...  Make sure you take this into account as you're designing/coding the following 
	stored procedures.

 - Adding new employees.  Return the key of the newly created employee, or an error message/code if something doesn't work.
 */

 CREATE OR ALTER PROCEDURE Group2_InsertEmployee
	@LastName varchar(25),
	@FirstName varchar(25),
	@Email varchar(50),
	@Hired date,
	@Terminated date,
	@DepartmentKey int,
	@SupervisorEmployeeKey int
AS 
BEGIN
	BEGIN TRY
	INSERT Group2_Employees 
	(
		LastName, 
		FirstName,
		Email,
		Hired,
		Terminated,
		DepartmentKey,
		SupervisorEmployeeKey
	) 
	VALUES 
	(
		@LastName, 
		@FirstName,
		@Email,
		@Hired,
		@Terminated,
		@DepartmentKey,
		@SupervisorEmployeeKey
	)
	END TRY
	BEGIN CATCH
		PRINT 'Unable to insert data! An Error occurred!'
		RETURN
	END CATCH

	RETURN SELECT SCOPE_IDENTITY() [EmployeeKey]
END

GO

 /*
 - Updating an employee
 */

 CREATE OR ALTER PROCEDURE Group2_UpdateEmployee
	@EmployeeKey int,
	@LastName varchar(25),
	@FirstName varchar(25),
	@Email varchar(50),
	@Hired date,
	@Terminated date,
	@DepartmentKey int,
	@SuperVisorEmployeeKey int
AS
BEGIN
	BEGIN TRY
		UPDATE Group2_Employees
		SET
		  LastName=@LastName,
		  FirstName=@FirstName,
		  Email=@Email,
		  Hired=@Hired,
		  Terminated=@Terminated,
		  DepartmentKey=@DepartmentKey,
		  SuperVisorEmployeeKey=@SuperVisorEmployeeKey
		WHERE
			EmployeeKey=@EmployeeKey
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Unable to update Employee ', @EmployeeKey, ': An Error occurred!')
		RETURN
	END CATCH
END
GO

 /*
 - Creating a new department.  Return the key of the newly created department or an error message/code if something doesn't work.
	Also, don't allow duplicate department names...
*/

CREATE OR ALTER PROCEDURE Group2_CreateDepartment
	@DepartmentKey_var int OUTPUT,
	@Department_var varchar(255)
AS
BEGIN
	BEGIN TRY
		DECLARE @ExistingDepartment int

		IF EXISTS
		(
			SELECT
				D.DepartmentKey
			FROM
				Group2_Departments D
			WHERE 
				D.Department = @Department_var
		)
		BEGIN
			PRINT CONCAT('Invalid Department Name [', @Department_var, ']: Department exists!')
			RETURN
		END
		ELSE
		BEGIN
			INSERT Group2_Departments(
				Department
				)
			VALUES (
				@Department_var
				)

			SET @DepartmentKey_var = SCOPE_IDENTITY()
			RETURN
		END
	END TRY
	BEGIN CATCH
		PRINT CONCAT('Unable to create Department! Is the department name unique? [', @Department_var, ']')
	END CATCH
END

GO

/*
 - Update the supervisor of an employee or employees.  Make sure it is a valid, active supervisor.
 */

-- Decided to put the burden of the loop on the front-end developer. Couldn't figure out a good way to
-- use a temporary table.
CREATE OR ALTER PROCEDURE Group2_UpdateSupervisor
	@SupervisorKey int,
	--@Employees EmployeeTableType READONLY,
	@EmployeeKey int,
	@Error nvarchar(255) OUTPUT
AS
BEGIN
	DECLARE @Terminated date

	-- Error checking
	-- Check for valid Supervisor
	IF NOT EXISTS 
	(
		SELECT 
			EmployeeKey
		FROM 
			Group2_Employees E
		WHERE 
			EmployeeKey = @SupervisorKey
	)
	BEGIN
		SET @Error = CONCAT('Invalid Supervisor key [', @SupervisorKey, ']: Employee does not exist!')
		RETURN
	END

	-- Check for active Supervisor record
	SELECT 
		@Terminated = E.Terminated
	FROM 
		Group2_Employees E
	WHERE 
		E.EmployeeKey = @SupervisorKey

	IF NOT @Terminated is null
	BEGIN
		SET @Error = CONCAT('Invalid Supervisor key [', @SupervisorKey, ']: Inactive Employee!')
		RETURN
	END
	
	-- Check for valid Employee
	IF NOT EXISTS 
	(
		SELECT 
			EmployeeKey
		FROM 
			Group2_Employees E
		WHERE 
			EmployeeKey = @EmployeeKey
	)
	BEGIN
		SET @Error = CONCAT('Invalid Employee key [', @EmployeeKey, ']: Employee does not exist!')
		RETURN
	END

	-- Check for active Employee record
	SELECT
		@Terminated = E.Terminated
	FROM
		Group2_Employees E
	WHERE
		E.EmployeeKey = @EmployeeKey

	IF NOT @Terminated is null
	BEGIN
		SET @Error = CONCAT('Invalid Employee key [', @EmployeeKey, ']: Inactive employee!')
		RETURN
	END

	-- Now, process it!
	UPDATE Group2_Employees
	SET
		SupervisorEmployeeKey = @SupervisorKey
	WHERE
		EmployeeKey = @EmployeeKey
END

GO

 /*
 - Return a computer
 */
 CREATE OR ALTER PROCEDURE Group2_ReturnComputer
	@computerKey int,
	@returned date

AS
BEGIN
	BEGIN TRY
		UPDATE Group2_EmployeeComputers
		SET
			Returned = @returned
		WHERE
			ComputerKey = @computerKey

		UPDATE Group2_Computers
		SET
			ComputerStatusKey = 2--,
			--ComputerStatusDate = GETDATE()
		WHERE
			computerKey = @computerKey
	END TRY
	BEGIN CATCH
		PRINT 'Unable to Return Computer! An error occurred'
		RETURN
	END CATCH

END

GO
 /*
 - Terminate an employee.  Harder one - what happens to an employee's equipment when they are terminated?
	What happens if the employee is a manager for other people?  I expect you to make this stored procedure
	bullet proof - don't expect the web developer to think about these things...
*/
CREATE OR ALTER PROCEDURE Group2_TerminateEmployee
	@EmployeeKey INT,
	@TerminationDate DATE
AS
BEGIN

	UPDATE Group2_Employees
	SET Terminated = @TerminationDate
	WHERE EmployeeKey = @EmployeeKey

	IF EXISTS (
		SELECT
			SupervisorEmployeeKey
		FROM 
			Group2_Employees
		WHERE 
			SupervisorEmployeeKey = @EmployeeKey
	)
	BEGIN
		DECLARE @currentSupervisor INT;
		SELECT
			@currentSupervisor = SupervisorEmployeeKey
		FROM 
			Group2_Employees
		WHERE 
			EmployeeKey = @EmployeeKey;

		UPDATE Group2_Employees
		SET 
			SupervisorEmployeeKey = @currentSupervisor
		WHERE 
			SupervisorEmployeeKey = @EmployeeKey;
	END
	ELSE
	BEGIN
		PRINT 'Error Terminating employee! Supervisor Does not exist!'
		RETURN
	END

	BEGIN TRY
		SELECT 
			EmployeeComputerKey,
			ComputerKey
		INTO 
			#computersToReturn
		FROM 
			Group2_EmployeeComputers
		WHERE 
			EmployeeKey = @EmployeeKey

		WHILE EXISTS (
			SELECT 
				EmployeeComputerKey
			FROM 
				#computersToReturn
		)
		BEGIN
			DECLARE @computerToReturn INT;
			DECLARE @returnedCompKey INT;

			SELECT TOP 1
				@returnedCompKey = EmployeeComputerKey,
				@computerToReturn = ComputerKey
			FROM 
				#computersToReturn

			EXEC Group2_ReturnComputer @computerToReturn, @TerminationDate

			DELETE FROM #computersToReturn
			WHERE EmployeeComputerKey = @returnedCompKey
		END
	END TRY
	BEGIN CATCH
		PRINT 'Error Terminating Employee! Unable to return all computers!'
		RETURN
	END CATCH
END

GO

/*
 - Create a new computer.  Return the key of the newly created computer, or an error message/code.
 */
 CREATE OR ALTER PROCEDURE Group2_AddComputer
	@computerTypeKey int,
	@BrandKey int,
	@ComputerStatusKey int,
	--@ComputerStatusDate date,
	@PurchaseDate date,
	@PurchaseCost money,
	@MomoryCapacityInGB int,
	@HardDriveCapacityInGB int,
	@VideoCardDescription varchar(255),
	@CPUTypeKey int,
	@CPUClockRateInGHZ decimal,
	@computerKey int OUTPUT

AS
BEGIN
	BEGIN TRY
		INSERT Group2_Computers(
			ComputerTypeKey, 
			BrandKey, 
			ComputerStatusKey, 
			--ComputerStatusDate,
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
			--@ComputerStatusDate,
			@PurchaseDate, 
			@PurchaseCost, 
			@MomoryCapacityInGB, 
			@HardDriveCapacityInGB, 
			@VideoCardDescription, 
			@CPUTypeKey, 
			@CPUClockRateInGHZ)
	END TRY
	BEGIN CATCH
		PRINT 'Error inserting computer! An Error ocurred!'
		RETURN
	END CATCH

	SELECT 
		@computerKey = MAX(ComputerKey)
	FROM Group2_Computers

	RETURN
END

GO

 /*
 - Assign/reassign a computer.  Shouldn't allow computers that are in for repair, lost, or retired to be assigned out.
 */
 CREATE OR ALTER PROCEDURE Group2_AssignComputer
	@ComputerKey int,
	@ComputerStatusKey int,
	@EmployeeKey int,
	@Assigned date
AS
	BEGIN
	IF EXISTS (
		SELECT
			ComputerStatusKey,
			ComputerKey
		FROM
			Group2_Computers
		WHERE
			ComputerStatusKey < 3 AND
			ComputerKey = @ComputerKey
		)
		BEGIN
			IF EXISTS (
				SELECT
					EmployeeComputerKey
				FROM 
					Group2_EmployeeComputers
				WHERE 
					ComputerKey = @ComputerKey AND
					Returned IS NULL
			)
			BEGIN
				RAISERROR('Computer is already assigned', 1, 1);
			END
			ELSE
			BEGIN
				INSERT INTO Group2_EmployeeComputers 
				(
					EmployeeKey, 
					ComputerKey, 
					Assigned
				)
				VALUES 
				(
					@EmployeeKey, 
					@ComputerKey, 
					@Assigned
				)
			END
		END
	END
GO

 /*
 - Change the status of a computer (lost computers, in for repairs, etc.)
 */
CREATE OR ALTER PROCEDURE Group2_UpdateComputerStatus
	@ComputerKey int,
	@ComputerStatus int
AS BEGIN
	UPDATE 
		Group2_Computers 
	SET 
		ComputerStatusKey=@ComputerStatus--,
		--ComputerStatusDate=GETDATE()
	WHERE
		ComputerKey=@ComputerKey
END

GO

 /*
 - Retire a computer.  Make sure the computer is fully depreciated, or do not let it be retired.
 */
 CREATE OR ALTER PROCEDURE Group2_RetireComputer
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
	FROM
		Group2_Computers
	WHERE 
		ComputerKey = @computerKey

	SET
		@depreciation = @computerOriginalCost - dbo.Group2_CalculateDepreciation (@computerTypeKey, @computerOriginalCost, @purchaseDate)
	
	UPDATE Group2_Computers
	SET
		ComputerStatusKey = 5--,
		--ComputerStatusDate = GETDATE()
	WHERE
		ComputerKey = @computerKey
		AND
		@depreciation <= 0

GO

 /*
Your compliance officer is adamant that certain safegaurds are installed in the database.  Consider the following:

 - No individual can have more than two working desktops or one working laptop assigned to them at any given time.
 */

CREATE OR ALTER TRIGGER Group2_EmployeeComputerInsert
ON Group2_EmployeeComputers
INSTEAD OF INSERT
AS
	BEGIN
		DECLARE @desktopcount INT, @laptopcount INT, @insertedCompType INT
		SELECT
			@desktopcount = COUNT(CASE c.ComputerTypeKey WHEN 1 THEN 1 ELSE NULL END),
			@laptopcount = COUNT(CASE c.ComputerTypeKey WHEN 2 THEN 1 ELSE NULL END)
		FROM
			Group2_EmployeeComputers ec
		LEFT JOIN Group2_Computers c ON
			ec.ComputerKey = c.ComputerKey
		WHERE
			EmployeeKey = (SELECT EmployeeKey FROM inserted) AND
			c.ComputerStatusKey < 3 AND
			ec.Returned IS NULL

		SELECT
			@insertedCompType = c.ComputerTypeKey
		FROM 
			inserted i
		LEFT JOIN Group2_Computers c ON 
			i.ComputerKey = c.ComputerKey

		IF ((@insertedCompType = 1 AND @desktopcount >= 2) OR (@insertedCompType = 2 AND @laptopcount >= 1))
			BEGIN
				RAISERROR('No individual can have more than two working desktops or one working laptop assigned to them at any given time.', 1, 1);
			END

		ELSE
			BEGIN
				INSERT INTO Group2_EmployeeComputers 
				(
					EmployeeKey, 
					ComputerKey, 
					Assigned, 
					Returned
				)
				SELECT
					EmployeeKey,
					ComputerKey,
					Assigned,
					Returned
				FROM inserted
			END
	END
GO

 /*
 - A hardcap of $10,000 has been put in place for the cost of any one computer.  Under no circumstances should the database
	have something above this.
	*/
ALTER TABLE Group2_Computers
	ADD CONSTRAINT _Group2_ComputerPrice 
	CHECK 
	(
		PurchaseCost BETWEEN 0 AND 10000
	)

	/*
 - Worried about piracy and bandwidth consumption, they have also institued a hard cap of hard drive space on any given 
	machine to 5TB.
	*/
ALTER TABLE Group2_Computers 
ADD CONSTRAINT Group2_Hdd5120GBLimit 
	CHECK (HardDriveCapacityinGB <= 5120)

	/*
 - Do not let anyone delete a computer record.  Can't happen!  We have to prove that no equipment is being purchased
	and removed from our systems to sell privately.  Instead of a delete, the computer should be retired, or
	made available (depending on its depreciation status).
	*/

	/*
Last, add features, safegaurds, etc. that help ensure the original goal - good data quality and graceful error handling.

Once your code is completed, provide scripts to complete the following (including display of output variables or errors as 
	applicable).

 - Create the department 'Business Intelligence'

 */

DECLARE @CaptureOutput int
EXEC Group2_CreateDepartment 
	@Department_var = 'Business Intelligence', 
	@DepartmentKey_var = @CaptureOutput

GO

 /*
 - Add two valid employee, both part of Business Intelligence
 */
EXEC Group2_InsertEmployee 
	@LastName = 'Sellars', 
	@FirstName = 'Peter', 
	@Email = 'peter.sellars@example.com', 
	@Hired = '1/19/2018', 
	@Terminated = NULL, 
	@DepartmentKey = 5, 
	@SupervisorEmployeeKey = 1

EXEC Group2_InsertEmployee 
	@LastName = 'Sellars', 
	@FirstName = 'John', 
	@Email = 'john.sellars@example.com', 
	@Hired = '1/12/2018', 
	@Terminated = NULL, 
	@DepartmentKey = 5, 
	@SupervisorEmployeeKey = 1

GO

 /*
 - Try to add an employee, passing in a department that doesn't exist
 */

EXEC Group2_InsertEmployee 
	@LastName = 'Reaper', 
	@FirstName = 'Grim', 
	@Email = 'fatherOfDeath@example.com', 
	@Hired = '1/12/2018', 
	@Terminated = NULL, 
	@DepartmentKey = 6, 
	@SupervisorEmployeeKey = 1
	--Should fail because the department has not yet been created.
GO

 /*
 - Try to add an employee, passing in a supervisor that is no longer active (what should this do?)
 */

 EXEC Group2_InsertEmployee 
	@LastName = 'Star', 
	@FirstName = 'Super', 
	@Email = 'smashMouth@example.com', 
	@Hired = '1/12/2018', 
	@Terminated = NULL, 
	@DepartmentKey = 5, 
	@SupervisorEmployeeKey = 2
	--Should fail because the supervisor is no longer active.

GO

 --- Update an employees department to 'Human Resources'
DECLARE @dptKey int
SET @dptKey = 
(
	SELECT 
		DepartmentKey 
	FROM 
		Group2_Departments 
	WHERE 
		Department='Accounting'
)

EXEC Group2_UpdateEmployee 
	3, 
	'Geek', 
	'Major', 
	'MGeek@thiscompany.com', 
	'2017-01-01', 
	NULL, 
	@dptKey, 
	1

GO

 --- Try to update an employees department to 'Moon Staff' (assuming that 'Moon Staff' doesn't exist
	--in your database).  
DECLARE @dptKey int
SET @dptKey = 
(
	SELECT
		DepartmentKey 
	FROM 
		Group2_Departments 
	WHERE 
		Department='Moon Staff'
)

EXEC Group2_UpdateEmployee 
	3, 
	'Geek', 
	'Major', 
	'MGeek@thiscompany.com', 
	'2017-01-01', 
	NULL, 
	@dptKey, 
	1
GO

 --- Update an employees supervisor to an active employee

 --- Try updating an employees supervisor to an inactive employee.  Should this work?
 UPDATE 
	Group2_Employees 
 SET 
	Terminated='2018-03-30' 
WHERE EmployeeKey=2

DECLARE @Error nvarchar(255)
EXEC Group2_UpdateSupervisor 
	2, 
	3, 
	@Error OUTPUT

SELECT @Error

--Set it back to normal
UPDATE 
	Group2_Employees 
SET 
	Terminated=NULL 
WHERE 
	EmployeeKey=2

GO

 --- Create a new Mac Book pro laptop for Major Geek.  Use whatever specs you can find off the Apple
	--web page.  Make sure the laptop gets assigned to Major Geek

DECLARE @newCompKey int;
EXEC Group2_AddComputer 
	2, 
	1, 
	0, 
	'3/24/2018', 
	--'3/24/2018', 
	1799.00, 
	8, 
	256, 
	'Intel Iris Plus Graphics 650', 
	2, 
	3.1, 
	@computerKey = @newCompKey OUTPUT;

EXEC Group2_AssignComputer 
	@newCompKey, 
	0, 
	3, 
	'3/24/2018';
GO

 --- Terminate employee #3 (Major Geek)
EXEC Group2_TerminateEmployee 
	3, 
	'3/26/2018'
GO

 --- A query using your inline table function to display available apple computers
SELECT
	*
FROM
	Group2_ComputersOfBrand(1)
GO

 --- A query (using inline view or stored procedure) that shows the history of a specific computer
	--in your database.
EXEC Group2_ComputerHistory 1

GO
 --- Deal with the CEO losing his laptop.
EXEC Group2_UpdateComputerStatus 2, 3

GO

 --- Add two computers of your own chosing
DECLARE @firstCompKey int;
DECLARE @secondCompKey int;
EXEC Group2_AddComputer 
	1, 
	1, 
	0, 
	'3/24/2018', 
	--'3/24/2018', 
	4999.00, 
	32, 
	1024, 
	'Radeon Pro Vega 56', 
	2, 
	3.2, 
	@computerKey = @firstCompKey OUTPUT;

EXEC Group2_AddComputer 
	2, 
	4, 
	0, 
	'3/24/2018', 
	--'3/24/2018', 
	999.99, 
	8, 
	256, 
	'Intel® UHD Graphics 620', 
	2, 
	1.6, 
	@computerKey = @secondCompKey OUTPUT;

 --- Query that shows all available computers/devices
SELECT
	*
FROM Group2_Computers

 --- Assign one of the new machines to the CEO
EXEC Group2_AssignComputer 
	@firstCompKey, 
	0, 
	1, 
	'3/24/2018';

 --- Return it and assign the other machine (the CEO hated your first choice)
EXEC Group2_ReturnComputer 
	@firstCompKey, 
	'3/24/2018';
EXEC Group2_AssignComputer 
	@secondCompKey, 
	0, 
	1, 
	'3/24/2018';

GO

 --- Try to retire the second machine you assigned to the CEO (he's picky...)
EXEC Group2_RetireComputer 6

 --- Query that leverages your view for depreciation values of lost equipment
SELECT
	*
FROM Group2_LostStolenComputers

GO

 /*
 - And any other queries/code execution to show your awesomeness

*/