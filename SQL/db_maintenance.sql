USE master;
GO

ALTER DATABASE cinema_booking_db
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

ALTER DATABASE cinema_booking_db
SET READ_ONLY;
GO

DECLARE @url NVARCHAR(100) = 'C:\SQL_Database_backup\cinema_booking_db.bak'; 
BACKUP DATABASE cinema_booking_db TO DISK = @url;
GO
  
ALTER DATABASE cinema_booking_db
SET READ_WRITE;
GO

ALTER DATABASE cinema_booking_db
SET MULTI_USER;
GO    
