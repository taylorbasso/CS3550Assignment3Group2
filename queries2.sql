--Update an employees department to 'Human Resources'
DECLARE @dptKey int
SET @dptKey = (SELECT DepartmentKey FROM Departments WHERE Department='Accounting')
EXEC dbo.Group3_UpdateEmployee 3, 'Geek', 'Major', 'MGeek@thiscompany.com', '2017-01-01', NULL, @dptKey, 1

--Try to update an employees department to 'Moon Staff' (assuming that 'Moon Staff' doesn't existin your database).
DECLARE @dptKey int
SET @dptKey = (SELECT DepartmentKey FROM Departments WHERE Department='Moon Staff')
EXEC dbo.Group3_UpdateEmployee 3, 'Geek', 'Major', 'MGeek@thiscompany.com', '2017-01-01', NULL, @dptKey, 1


--Update an employees supervisor to an active employee
DECLARE @output nvarchar(255)
EXEC dbo.Group2_UpdateSupervisor 2, 3, @output OUTPUT
SELECT @output
--Set it back to normal
UPDATE Employees SET SupervisorEmployeeKey=1 WHERE EmployeeKey=3

--Try updating an employees supervisor to an inactive employee. Should this work?
UPDATE Employees SET Terminated='2018-03-30' WHERE EmployeeKey=2
DECLARE @Error nvarchar(255)
EXEC dbo.Group2_UpdateSupervisor 2, 3, @Error OUTPUT
SELECT @Error
--Set it back to normal
UPDATE Employees SET Terminated=NULL WHERE EmployeeKey=2
