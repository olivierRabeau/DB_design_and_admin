--The authentication mechanism is the act by which a login account attempts 
--to access the SQL server. 
--As soon as it is authenticated, the connection turns into a session and 
--allows to navigate a database on the server through a SQL user. 
--Everyone (login account and user) has privileges...

--A connection is used to connect to a SQL Server. 
--It is registered in the master database. 

--A SQL user is used to navigate a database. 
--It is saved in the database for which it accesses the objects.

--MUST_CHANGE

--********************************* LOGINS *************************************
--SQL SERVER level

USE master;

--If login account does not exist, creates the login saved in the master database. 
IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = 'C_admin') 
CREATE LOGIN C_admin WITH PASSWORD = 'admin';  

IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = 'C_prog' ) 
CREATE LOGIN C_prog WITH PASSWORD = 'prog';

IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = 'C_proj' ) 
CREATE LOGIN C_proj WITH PASSWORD = 'proj';

IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = 'C_cclerk' ) 
CREATE LOGIN C_cclerk WITH PASSWORD = 'cclerk';

GO  

--********************************** USERS *************************************
--DATABASE level

USE cinema_booking_db;

-- If user does not exist, creates a database user for the login created above. 
IF USER_ID('U_admin') IS NULL 
    CREATE USER U_admin FOR LOGIN C_admin;  
GO  

IF USER_ID('U_prog') IS NULL 
    CREATE USER U_prog FOR LOGIN C_prog;  
GO  

IF USER_ID('U_proj') IS NULL 
    CREATE USER U_proj FOR LOGIN C_proj;  
GO 

IF USER_ID('U_cclerk') IS NULL 
    CREATE USER U_cclerk FOR LOGIN C_cclerk;  
GO  

--******************************** PRIVILEGES **********************************








