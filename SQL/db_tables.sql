--Places the user in the context of master
USE master;

--if the database doesn't exist it is created
--without GO command it fails -> Batch separator is needed
--GO signals the end of a batch of Transact-SQL statements to the SQL Server utilities.
IF DB_ID ('cinema_booking_db') IS NULL
CREATE DATABASE cinema_booking_db;
GO

--tables creation for the database  
--identity creates an auto incremented value (seed, increment) 

--Places user in the context of the brand new database
USE cinema_booking_db;
GO

IF OBJECT_ID('T_logins') IS NULL
CREATE TABLE T_logins 
(
	login_id INT IDENTITY(1,1) NOT NULL,	
	login_name NVARCHAR(255) NOT NULL,
	login_password NVARCHAR(255) NOT NULL,                              
	CONSTRAINT PK_logins_id PRIMARY KEY (login_id)
);

INSERT INTO T_logins (login_name, login_password) 
VALUES ('avikander', 'laracroft$'),('gclooney', 'ocean11'),('jblack', 'jumanji*');

IF OBJECT_ID('T_complexes') IS NULL
CREATE TABLE T_complexes 
( 
	complex_id INT IDENTITY(1,1) NOT NULL,
	complex_name NVARCHAR(255) NOT NULL,
	complex_address NVARCHAR(255) NOT NULL,
	complex_phone NVARCHAR(255) NOT NULL,
	complex_email NVARCHAR(255) NOT NULL,
	CONSTRAINT PK_complexes_id PRIMARY KEY (complex_id)
);

IF OBJECT_ID('T_roles') IS NULL
CREATE TABLE T_roles 
(
	role_id INT IDENTITY(1,1) NOT NULL,
	role_name NVARCHAR(255) NOT NULL,
	CONSTRAINT PK_roles_id PRIMARY KEY (role_id)
);

IF OBJECT_ID('T_employees') IS NULL
CREATE TABLE T_employees 
(
	employee_id INT IDENTITY(1,1) NOT NULL,	
	employee_name NVARCHAR(255) NOT NULL,
	employee_firstname NVARCHAR(255) NOT NULL,
	employee_address NVARCHAR(255) NOT NULL,
	employee_phone NVARCHAR(255) NOT NULL,
	employee_email NVARCHAR(255) NOT NULL,
	employee_complex INT NOT NULL,
	employee_login INT NOT NULL,
	employee_role INT NOT NULL,
	CONSTRAINT PK_employees_id PRIMARY KEY (employee_id),
	CONSTRAINT FK_employees_complex FOREIGN KEY (employee_complex) REFERENCES T_complexes(complex_id)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_employees_account FOREIGN KEY (employee_login) REFERENCES T_logins(login_id)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_employees_role FOREIGN KEY (employee_role) REFERENCES T_roles(role_id)
	ON DELETE CASCADE ON UPDATE CASCADE,
);

IF OBJECT_ID('T_rooms') IS NULL
CREATE TABLE T_rooms 
(
	room_id INT IDENTITY(1,1) NOT NULL,	
	room_number INT NOT NULL,
	room_seats INT NOT NULL,
	room_complex INT NOT NULL,
	CONSTRAINT PK_rooms_id PRIMARY KEY (room_id),
	CONSTRAINT FK_rooms_complex FOREIGN KEY (room_complex) REFERENCES T_complexes(complex_id)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT UK_rooms_number UNIQUE (room_complex, room_number)
);

IF OBJECT_ID('T_movies') IS NULL
CREATE TABLE T_movies 
( 
	movie_id INT IDENTITY(1,1) NOT NULL,	
	movie_title NVARCHAR(255) NOT NULL,
	movie_gender NVARCHAR(255) NOT NULL,
	movie_director NVARCHAR(255) NOT NULL,
	movie_actors NVARCHAR(255) NOT NULL,
	movie_synopsis NVARCHAR(255) NOT NULL,
	movie_duration_minutes INT NOT NULL,
	CONSTRAINT PK_movies_id PRIMARY KEY (movie_id),
);

IF OBJECT_ID('T_movies_screenings') IS NULL
CREATE TABLE T_movies_screenings 
(
	mvscr_id INT IDENTITY(1,1) NOT NULL,	
	mvscr_date_time_group DATETIME NOT NULL,
	mvscr_movie INT NOT NULL,
	mvscr_room INT NOT NULL,
	CONSTRAINT PK_movies_screenings_id PRIMARY KEY (mvscr_id),
	CONSTRAINT FK_movies_screenings_movie FOREIGN KEY (mvscr_movie) REFERENCES T_movies(movie_id),
	CONSTRAINT FK_movies_screenings_room FOREIGN KEY (mvscr_room) REFERENCES T_rooms(room_id)
);

IF OBJECT_ID('T_prices') IS NULL
CREATE TABLE T_prices 
(
	price_id INT IDENTITY(1,1) NOT NULL,
	price_category NVARCHAR(255) NOT NULL,
	price_amount_euros FLOAT NOT NULL,
	CONSTRAINT PK_prices_id PRIMARY KEY (price_id)
); 

IF OBJECT_ID('T_reductions') IS NULL
CREATE TABLE T_reductions 
(
	reduction_id INT IDENTITY(1,1) NOT NULL,
	reduction_category NVARCHAR(255) NOT NULL,
	reduction_amount_euros FLOAT NOT NULL,
	CONSTRAINT PK_reductions_id PRIMARY KEY (reduction_id)
); 

IF OBJECT_ID('T_customers') IS NULL
CREATE TABLE T_customers 
(
	customer_id INT IDENTITY(1,1) NOT NULL,
	customer_name NVARCHAR(255) NOT NULL,
	customer_firstname NVARCHAR(255) NOT NULL,
	customer_phone NVARCHAR(255) NOT NULL,
	customer_email NVARCHAR(255) NOT NULL,
	CONSTRAINT PK_customers_id PRIMARY KEY (customer_id)
); 

IF OBJECT_ID('T_reservations') IS NULL
CREATE TABLE T_reservations 
(
    reservation_id INT IDENTITY(1,1) NOT NULL,
	reservation_customer INT NOT NULL,
	reservation_mvscr INT NOT NULL,
	reservation_price INT NOT NULL,
	reservation_reduction INT DEFAULT 0,
	CONSTRAINT PK_reservations_id PRIMARY KEY CLUSTERED (reservation_id),
	CONSTRAINT FK_reservations_customer FOREIGN KEY (reservation_customer) REFERENCES T_customers(customer_id),
	CONSTRAINT FK_reservations_mvscr FOREIGN KEY (reservation_mvscr) REFERENCES T_movies_screenings(mvscr_id),
	CONSTRAINT FK_reservations_price FOREIGN KEY (reservation_price) REFERENCES T_prices(price_id),
	CONSTRAINT FK_reservations_reduction FOREIGN KEY (reservation_reduction) REFERENCES T_reductions(reduction_id),
);

--check if customized function is already stored in 
--INFORMATION_SCHEMA.ROUTINES view from MASTER database
--if not that creates it
IF NOT EXISTS (SELECT SPECIFIC_NAME FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME='get_total_amount')
EXEC sp_executesql N'
	CREATE FUNCTION get_total_amount (@customer INT)
	RETURNS INT
	AS
	BEGIN
		RETURN (
			SELECT SUM(T_reservations.reservation_price) - SUM (T_reservations.reservation_reduction)
			FROM T_reservations WHERE reservation_customer = @customer
		);
	END
';

--without stored procedure it must have been like below
--because CREATE FUNCTION must be the only statement ine the batch
--it requires GO command before and after definition
--Condition creation wouldn't have been allowed without rising an exception
--GO
--	CREATE FUNCTION get_total_amount (@customer INT)
--	RETURNS INT
--	AS
--	BEGIN
--		RETURN (
--			SELECT SUM(T_reservations.reservation_price) - SUM (T_reservations.reservation_reduction)
--			FROM T_reservations WHERE reservation_customer = @customer
--		);
--	END
--GO

--scalar function is used to create a calculated column
IF OBJECT_ID('T_invoices') IS NULL
CREATE TABLE T_invoices 
(
	invoice_id INT IDENTITY(1,1) NOT NULL,
	invoice_customer INT NOT NULL,
	invoice_amount AS dbo.get_total_amount (invoice_customer),	
	invoice_payment_mode NVARCHAR(255) NOT NULL,
	invoice_payment_done BIT NOT NULL,
	CONSTRAINT PK_invoices_id PRIMARY KEY (invoice_id),
	CONSTRAINT FK_invoices_customer FOREIGN KEY (invoice_customer) REFERENCES T_customers(customer_id)
); 
 

