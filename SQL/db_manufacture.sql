--Requires to be connected with "sa" login 

--Places the user in the context of master
USE master;
GO

---------------------------------- DATABASE ------------------------------------

--If the option UTF8 isn't selected, SQL Server uses the default 
--non-Unicode encoding format for the applicable data types

--Collation specifies how data is sorted and compared in a database.
--database collation : 
--100 new version
--CS case sensitive
--AS accent sensitive
--KS kana sensitive (japan)
--WS width sensitive
--SC special characters
--UTF8 for unicode encoding

--SELECT * FROM sys.fn_helpcollations() WHERE name LIKE '%UTF8%';

IF DB_ID ('cinema_booking_db') IS NULL
CREATE DATABASE cinema_booking_db
COLLATE FRENCH_100_CS_AS_KS_WS_SC_UTF8;
GO

--The authentication mechanism is the act by which a login account attempts 
--to access the SQL server. 
--As soon as it is authenticated, the connection turns into a session and 
--allows to navigate a database on the server through a SQL user. 
--Everyone (login account and user) has privileges...

--A connection is used to connect to a SQL Server. 
--It is registered in the master database. 

--A SQL user is used to navigate a database. 
--It is saved in the database for which it accesses the objects.

----------------------------------- LOGINS -------------------------------------

--SQL SERVER level

USE master;
GO

--If login account does not exist, creates the login saved in the master database. 
IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = 'CNX_administrator') 
CREATE LOGIN CNX_administrator WITH PASSWORD = 'admin';  

IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = 'CNX_manager') 
CREATE LOGIN CNX_manager WITH PASSWORD = 'manage';  

IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = 'CNX_accountant' ) 
CREATE LOGIN CNX_accountant WITH PASSWORD = 'account';

IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = 'CNX_programmer' ) 
CREATE LOGIN CNX_programmer WITH PASSWORD = 'prog';

IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = 'CNX_counter_clerk' ) 
CREATE LOGIN CNX_counter_clerk WITH PASSWORD = 'cclerk';

GO  

------------------------------------ USERS -------------------------------------

--DATABASE level

USE cinema_booking_db;

IF USER_ID('USR_administrator') IS NULL 
    CREATE USER USR_administrator FOR LOGIN CNX_administrator;  
GO  

IF USER_ID('USR_manager') IS NULL 
    CREATE USER USR_manager FOR LOGIN CNX_manager;
GO  

IF USER_ID('USR_accountant') IS NULL 
    CREATE USER USR_accountant FOR LOGIN CNX_accountant;  
GO  

IF USER_ID('USR_programmer') IS NULL 
    CREATE USER USR_programmer FOR LOGIN CNX_programmer;  
GO  

IF USER_ID('USR_counter_clerk') IS NULL 
    CREATE USER USR_counter_clerk FOR LOGIN CNX_counter_clerk;  
GO  

----------------------------------- SCHEMAS ------------------------------------

--The choice is to deal with security at schemas level.

Use cinema_booking_db;
GO

IF NOT EXISTS (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'S_management' )
EXEC sp_executesql N'CREATE SCHEMA S_management  AUTHORIZATION USR_administrator';
GO

IF NOT EXISTS (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'S_accounting' )
EXEC sp_executesql N'CREATE SCHEMA S_accounting  AUTHORIZATION USR_administrator';
GO

IF NOT EXISTS (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'S_programming' )
EXEC sp_executesql N'CREATE SCHEMA S_programming  AUTHORIZATION USR_administrator';
GO

IF NOT EXISTS (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'S_reception' )
EXEC sp_executesql N'CREATE SCHEMA S_reception  AUTHORIZATION USR_administrator';
GO

---------------------------------- PRIVILEGES ----------------------------------

--SQL SERVER level
USE master;
GO

GRANT ADMINISTER BULK OPERATIONS, ALTER ANY DATABASE, ALTER ANY LOGIN, 
CREATE ANY DATABASE, VIEW ANY DATABASE TO CNX_administrator
GO

--DATABASE level
USE cinema_booking_db;
GO

EXEC sp_addrolemember 'db_owner', 'USR_administrator'
EXEC sp_addrolemember 'db_backupoperator', 'USR_administrator'
EXEC sp_addrolemember 'db_securityadmin', 'USR_administrator'
EXEC sp_addrolemember 'db_accessadmin', 'USR_administrator'
EXEC sp_addrolemember 'db_ddladmin', 'USR_administrator'
EXEC sp_addrolemember 'db_datawriter', 'USR_administrator'
EXEC sp_addrolemember 'db_datareader', 'USR_administrator'
GO

--SCHEMA level

GRANT INSERT, DELETE, UPDATE, SELECT ON SCHEMA::S_management 
TO USR_manager;
GO

GRANT INSERT, DELETE, UPDATE, SELECT ON SCHEMA::S_accounting 
TO USR_accountant;
GO

GRANT INSERT, DELETE, UPDATE, SELECT ON SCHEMA::S_programming 
TO USR_programmer;
GO

GRANT INSERT, DELETE, UPDATE, SELECT ON SCHEMA::S_reception 
TO USR_counter_clerk;
GO

--Object level : tables

GRANT SELECT ON S_management.T_rooms 
TO USR_programmer
GO

GRANT SELECT ON S_accounting.T_invoices 
TO USR_counter_clerk;
GO

GRANT SELECT ON S_accounting.T_payments 
TO USR_counter_clerk;
GO

GRANT EXECUTE ON OBJECT::S_accounting.P_create_invoice 
TO USR_counter_clerk;
GO  

--********************************* TABLES ************************************

--the use of unicode types (nchar , nvarchar et ntext) allows
--foreigns movies titles to be written and read properly

--identity creates an auto incremented value (seed, increment) 

--Places user in the context of the brand new database
USE cinema_booking_db;
GO

IF OBJECT_ID('S_management.T_complexes', N'U') IS NULL
CREATE TABLE S_management.T_complexes 
( 
	complex_id INT IDENTITY(1,1) NOT NULL,
	complex_name NVARCHAR(255) NOT NULL,
	complex_address NVARCHAR(255) NOT NULL,
	complex_town NVARCHAR(255) NOT NULL,
	complex_phone NVARCHAR(255) NOT NULL,
	complex_email NVARCHAR(255) NOT NULL,
	CONSTRAINT PK_complexes_id PRIMARY KEY (complex_id)
);
GO

IF OBJECT_ID('S_management.T_rooms', N'U') IS NULL
CREATE TABLE S_management.T_rooms 
(
	room_id INT IDENTITY(1,1) NOT NULL,	
	room_number INT NOT NULL,
	room_seats INT NOT NULL,
	room_complex INT NOT NULL,
	room_availability BIT NOT NULL DEFAULT 1,
	CONSTRAINT PK_rooms_id PRIMARY KEY (room_id),
	CONSTRAINT FK_rooms_complex FOREIGN KEY (room_complex) REFERENCES S_management.T_complexes(complex_id)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT UK_rooms_complex_number UNIQUE (room_complex, room_number)
);
GO

IF OBJECT_ID('S_management.T_roles', N'U') IS NULL
CREATE TABLE S_management.T_roles 
(
	role_id INT IDENTITY(1,1) NOT NULL,
	role_name NVARCHAR(255) NOT NULL,
	CONSTRAINT PK_roles_id PRIMARY KEY (role_id)
);
GO

IF OBJECT_ID('S_management.T_employees', N'U') IS NULL
CREATE TABLE S_management.T_employees 
(
	employee_id INT IDENTITY(1,1) NOT NULL,	
	employee_name NVARCHAR(255) NOT NULL,
	employee_firstname NVARCHAR(255) NOT NULL,
	employee_address NVARCHAR(255) NOT NULL,
	employee_phone NVARCHAR(255) NOT NULL,
	employee_email NVARCHAR(255) NOT NULL,
	employee_complex INT NOT NULL,
	employee_role INT NOT NULL,
	CONSTRAINT PK_employees_id PRIMARY KEY (employee_id),
	CONSTRAINT FK_employees_complex FOREIGN KEY (employee_complex) REFERENCES S_management.T_complexes(complex_id),
	CONSTRAINT FK_employees_role FOREIGN KEY (employee_role) REFERENCES S_management.T_roles(role_id),
	CONSTRAINT C_employees_email CHECK (employee_email LIKE N'%@%.%')
);
GO

IF OBJECT_ID('S_programming.T_movies', N'U') IS NULL
CREATE TABLE S_programming.T_movies 
( 
	movie_id INT IDENTITY(1,1) NOT NULL,	
	movie_title NVARCHAR(255) NOT NULL,
	movie_gender NVARCHAR(255) NOT NULL,
	movie_director NVARCHAR(255) NOT NULL,
	movie_actors NVARCHAR(500),
	movie_synopsis NVARCHAR(500) NOT NULL,
	movie_duration_minutes INT NOT NULL,
	CONSTRAINT PK_movies_id PRIMARY KEY (movie_id),
	CONSTRAINT UK_movies_title_gender_director UNIQUE (movie_title, movie_gender, movie_director)
);
GO

IF OBJECT_ID('S_programming.T_movies_screenings', N'U') IS NULL
CREATE TABLE S_programming.T_movies_screenings 
(
	mvscr_id INT IDENTITY(1,1) NOT NULL,	
	mvscr_date_time_group DATETIME NOT NULL,
	mvscr_movie INT NOT NULL,
	mvscr_room INT NOT NULL,
	CONSTRAINT PK_movies_screenings_id PRIMARY KEY (mvscr_id),
	CONSTRAINT FK_movies_screenings_movie FOREIGN KEY (mvscr_movie) REFERENCES S_programming.T_movies(movie_id),
	CONSTRAINT FK_movies_screenings_room FOREIGN KEY (mvscr_room) REFERENCES S_management.T_rooms(room_id)
);
GO

IF OBJECT_ID('S_accounting.T_prices', N'U') IS NULL
CREATE TABLE S_accounting.T_prices 
(
	price_id INT IDENTITY(1,1) NOT NULL,
	price_category NVARCHAR(255) NOT NULL,
	price_amount_euros MONEY NOT NULL,
	CONSTRAINT PK_prices_id PRIMARY KEY (price_id)
); 
GO

IF OBJECT_ID('S_accounting.T_reductions', N'U') IS NULL
CREATE TABLE S_accounting.T_reductions 
(
	reduction_id INT IDENTITY(1,1) NOT NULL,
	reduction_category NVARCHAR(255) NOT NULL,
	reduction_amount_euros MONEY NOT NULL,
	CONSTRAINT PK_reductions_id PRIMARY KEY (reduction_id)
); 
GO

IF OBJECT_ID('S_reception.T_customers', N'U') IS NULL
CREATE TABLE S_reception.T_customers 
(
	customer_id INT IDENTITY(1,1) NOT NULL,
	customer_name NVARCHAR(255) NOT NULL,
	customer_firstname NVARCHAR(255) NOT NULL,
	customer_phone NVARCHAR(255) NOT NULL,
	customer_email NVARCHAR(255) NOT NULL,
	CONSTRAINT PK_customers_id PRIMARY KEY (customer_id),
	CONSTRAINT C_customers_email CHECK (customer_email LIKE N'%@%.%')
); 
GO

IF OBJECT_ID('S_reception.T_reservations', N'U') IS NULL
CREATE TABLE S_reception.T_reservations 
(
    reservation_id INT IDENTITY(1,1) NOT NULL,
	reservation_customer INT NOT NULL,
	reservation_mvscr INT NOT NULL,
	reservation_price INT NOT NULL,
	reservation_reduction INT,
	CONSTRAINT PK_reservations_id PRIMARY KEY (reservation_id),
	CONSTRAINT FK_reservations_customer FOREIGN KEY (reservation_customer) REFERENCES S_reception.T_customers(customer_id),
	CONSTRAINT FK_reservations_mvscr FOREIGN KEY (reservation_mvscr) REFERENCES S_programming.T_movies_screenings(mvscr_id),
	CONSTRAINT FK_reservations_price FOREIGN KEY (reservation_price) REFERENCES S_accounting.T_prices(price_id),
	CONSTRAINT FK_reservations_reduction FOREIGN KEY (reservation_reduction) REFERENCES S_accounting.T_reductions(reduction_id),
);
GO

IF NOT EXISTS (SELECT SPECIFIC_NAME FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME='P_create_invoice')
EXEC sp_executesql N'
CREATE PROCEDURE S_accounting.P_create_invoice
(
	@customer_id INT, 
	@mvscr_id INT
)
AS
BEGIN TRY
	INSERT INTO S_accounting.T_invoices (invoice_customer, invoice_mvscr, invoice_amount) 
	SELECT
		reservation_customer,
    	reservation_mvscr,
    	SUM (price_amount_euros - ISNULL(reduction_amount_euros, 0))
	FROM S_reception.T_reservations
	INNER JOIN S_accounting.T_prices ON reservation_price = price_id
	LEFT JOIN S_accounting.T_reductions ON reservation_reduction = reduction_id
	WHERE reservation_customer = @customer_id AND reservation_mvscr = @mvscr_id
	GROUP BY reservation_customer, reservation_mvscr
END TRY
BEGIN CATCH
END CATCH';

IF OBJECT_ID('S_accounting.T_invoices', N'U') IS NULL
CREATE TABLE S_accounting.T_invoices
(
	invoice_id INT IDENTITY(1,1) NOT NULL,
	invoice_customer INT NOT NULL,
	invoice_mvscr INT NOT NULL,
	invoice_amount MONEY NOT NULL,
	CONSTRAINT PK_invoices_id PRIMARY KEY (invoice_id),
	CONSTRAINT FK_invoices_customer FOREIGN KEY (invoice_customer) REFERENCES S_reception.T_customers(customer_id),
	CONSTRAINT FK_invoices_mvscr FOREIGN KEY (invoice_mvscr) REFERENCES S_programming.T_movies_screenings(mvscr_id),
	CONSTRAINT UK_invoices_customer_mvscr UNIQUE (invoice_customer, invoice_mvscr)
)
GO

IF OBJECT_ID('S_accounting.T_payments', N'U') IS NULL
CREATE TABLE S_accounting.T_payments
(
	payment_id INT IDENTITY(1,1) NOT NULL,
	payment_invoice INT NOT NULL,
	payment_mode INT NOT NULL,
	payment_date DATETIME NOT NULL,
	CONSTRAINT PK_payments_id PRIMARY KEY (payment_id),
	CONSTRAINT FK_payments_invoice FOREIGN KEY (payment_invoice) REFERENCES S_accounting.T_invoices(invoice_id),
	CONSTRAINT UK_payments_invoice UNIQUE (payment_invoice)
)
GO
------------------------------------- views ------------------------------------

USE cinema_booking_db;
GO 

IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='V_availables_seats')
EXEC sp_executesql N'
CREATE VIEW S_reception.V_availables_seats
AS
    SELECT movie_title, mvscr_room, room_seats, (room_seats - COUNT(reservation_id)) AS availables_seats FROM S_management.T_rooms
    INNER JOIN S_programming.T_movies_screenings ON room_id = mvscr_room
    INNER JOIN S_reception.T_reservations ON mvscr_id = reservation_mvscr
    INNER JOIN S_programming.T_movies ON movie_id = mvscr_movie
    GROUP BY movie_title, mvscr_room, room_seats';

--S_reception.V_reservations

IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='V_reservations')
EXEC sp_executesql N'
CREATE VIEW S_reception.V_reservations AS
SELECT 
customer_name AS Name, 
customer_firstname AS Firstname,
movie_title AS Movie, 
movie_gender AS Gender, 
FORMAT(mvscr_date_time_group, ''D'', ''fr-FR'') AS Day, 
FORMAT(mvscr_date_time_group, ''H : mm'') AS Session,
complex_name AS Complex,
room_number AS Room,
price_category AS Tariff, 
reduction_category AS Reduction, 
(price_amount_euros - ISNULL(reduction_amount_euros,0)) AS Price_in_euros
FROM S_reception.T_reservations
INNER JOIN S_reception.T_customers ON reservation_customer = T_customers.customer_id
INNER JOIN S_programming.T_movies_screenings ON reservation_mvscr = T_movies_screenings.mvscr_id
INNER JOIN S_programming.T_movies ON T_movies_screenings.mvscr_movie = T_movies.movie_id
INNER JOIN S_accounting.T_prices ON T_prices.price_id = reservation_price
LEFT JOIN S_accounting.T_reductions ON T_reductions.reduction_id = reservation_reduction
INNER JOIN S_management.T_rooms ON T_movies_screenings.mvscr_room = T_rooms.room_id
INNER JOIN S_management.T_complexes ON T_rooms.room_complex = T_complexes.complex_id';

--S_accounting.V_invoices

IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='V_invoices')
EXEC sp_executesql N'
CREATE VIEW S_accounting.V_invoices AS
SELECT 
customer_id,
mvscr_id,
customer_name,
customer_firstname,
movie_title, 
mvscr_date_time_group, 
SUM (price_amount_euros - ISNULL(reduction_amount_euros,0)) AS Price_in_euros
FROM S_reception.T_reservations
INNER JOIN S_reception.T_customers ON reservation_customer = T_customers.customer_id
INNER JOIN S_programming.T_movies_screenings ON reservation_mvscr = T_movies_screenings.mvscr_id
INNER JOIN S_programming.T_movies ON T_movies_screenings.mvscr_movie = T_movies.movie_id
INNER JOIN S_management.T_rooms ON T_movies_screenings.mvscr_room = T_rooms.room_id
INNER JOIN S_accounting.T_prices ON reservation_price = price_id
LEFT JOIN S_accounting.T_reductions ON reservation_reduction = reduction_id
INNER JOIN S_management.T_complexes ON T_rooms.room_complex = T_complexes.complex_id
GROUP BY customer_id, mvscr_id, customer_name, customer_firstname, movie_title, mvscr_date_time_group ';

--S_management.V_complexes_stats

IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='V_complexes_stats')
EXEC sp_executesql N'
CREATE VIEW S_management.V_complexes_stats
AS
SELECT 
	complex_name, 
	COUNT (room_id) AS total_rooms, 
	SUM(room_seats) AS total_number_of_seats, 
	AVG(room_seats) AS average_number_of_seats, 
	MAX(room_seats) AS max_number_of_seats, 
	MIN(room_seats) AS min_number_of_seats 
FROM S_management.T_complexes 
INNER JOIN S_management.T_rooms ON complex_id = room_complex
WHERE room_complex = complex_id
GROUP BY complex_name';

--S_programming.V_movies_stats

IF NOT EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='V_movies_stats')
EXEC sp_executesql N'
CREATE VIEW S_programming.V_movies_stats
AS
SELECT
COALESCE(complex_town,'''') AS complex_town,
COALESCE(movie_gender, '''') AS movie_gender, 
COALESCE(movie_title, '''') AS movie_title, 
CONCAT(DATEPART(iso_week, mvscr_date_time_group),DATEPART(year, mvscr_date_time_group)) AS week_year,
COUNT(reservation_id) AS number_of_entries
FROM S_reception.T_reservations
INNER JOIN S_programming.T_movies_screenings ON reservation_mvscr = mvscr_id
INNER JOIN S_programming.T_movies ON mvscr_movie = movie_id
INNER JOIN S_management.T_rooms ON mvscr_room = room_id
INNER JOIN S_management.T_complexes ON room_complex = complex_id
GROUP BY ROLLUP (complex_town, movie_gender, movie_title, mvscr_date_time_group)
';
