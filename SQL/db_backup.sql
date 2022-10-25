--Requires to be connected with "sa" login 
--or USR_administrator if database has been migrated to partially contained

--Diconnect other users
ALTER DATABASE cinema_booking_db
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

--Set database in read mode
ALTER DATABASE cinema_booking_db
SET READ_ONLY;
GO
--------------------------- administrator settings -----------------------------

DECLARE @url NVARCHAR(100) = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\Backup\cinema_booking_db.bak'; 

--------------------------------------------------------------------------------

--Save database 
BACKUP DATABASE cinema_booking_db TO DISK = @url;
GO

--Set database in read and write mode
ALTER DATABASE cinema_booking_db
SET READ_WRITE;
GO

--Allow others users to connect to the database
ALTER DATABASE cinema_booking_db
SET MULTI_USER;
GO    

