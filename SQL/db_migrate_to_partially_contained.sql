--Requires to be connected with "sa" login 
--Migrate to a Partially Contained Database

sp_configure 'contained database authentication', 1;  
GO  
RECONFIGURE ;  
GO  

--Disconnect other users

ALTER DATABASE cinema_booking_db
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

--Ensure write mode to allow SET CONTAINEMENT = PARTIAL

ALTER DATABASE cinema_booking_db
SET READ_WRITE;
GO

--Converting a Database to Partially Contained

GO  
ALTER DATABASE cinema_booking_db SET CONTAINMENT = PARTIAL  
GO  

--Allow multi-user 

ALTER DATABASE cinema_booking_db
SET MULTI_USER;
GO    

--The contained database user model supports both Windows authentication 
--and SQL Server authentication, and can be used in both SQL Server and SQL Database. 
--To connect as a contained database user, the connection string must always contain 
--a parameter for the user database so that the Database Engine knows which database 
--is responsible for managing the authentication process. 

--Use of the stored procedure sp_migrate_user_to_contained to migrate
--users to contained users in the user database and to delete logins in the database
--named master

USE cinema_booking_db;
GO

EXECUTE sp_migrate_user_to_contained   
    @username = USR_administrator,  
    @rename = N'keep_name',  
    @disablelogin = N'disable_login';  

EXECUTE sp_migrate_user_to_contained   
    @username = USR_manager,  
    @rename = N'keep_name',  
    @disablelogin = N'disable_login';  

EXECUTE sp_migrate_user_to_contained   
    @username = USR_programmer,  
    @rename = N'keep_name',  
    @disablelogin = N'disable_login';  

EXECUTE sp_migrate_user_to_contained   
    @username = USR_accountant,  
    @rename = N'keep_name',  
    @disablelogin = N'disable_login';  

EXECUTE sp_migrate_user_to_contained   
    @username = USR_counter_clerk,  
    @rename = N'keep_name',  
    @disablelogin = N'disable_login'; 