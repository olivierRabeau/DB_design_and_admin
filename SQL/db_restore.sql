--Requires to be connected with "sa" login 

USE master;
GO

--------------------------- administrator settings -----------------------------

DECLARE @url NVARCHAR(100) = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\Backup\cinema_booking_db.bak'; 

--------------------------------------------------------------------------------

RESTORE DATABASE cinema_booking_db FROM DISK = @url;

--Set database in read and write mode
ALTER DATABASE cinema_booking_db
SET READ_WRITE;
GO

--Allow others users to connect to the database
ALTER DATABASE cinema_booking_db
SET MULTI_USER;
GO    