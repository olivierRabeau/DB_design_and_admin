USE master;  

--if the database doesn't exist it is created
IF DB_ID (N'cinema_booking_app') IS NULL
CREATE DATABASE cinema_booking_app;

--Create tables for the database
--identity creates an auto incremented value (seed, increment) 
USE cinema_booking_app;

IF OBJECT_ID(N'complexes') IS NULL
CREATE TABLE complexes 
(
	id INT IDENTITY(1,1) NOT NULL,
	CONSTRAINT PK_complexes_id PRIMARY KEY CLUSTERED (id)
);

IF OBJECT_ID(N'rooms') IS NULL
CREATE TABLE rooms 
(
	id INT IDENTITY(1,1) NOT NULL,
	complex INT NOT NULL,
	room_number INT NOT NULL,
	seats INT NOT NULL,
	CONSTRAINT PK_rooms_id PRIMARY KEY CLUSTERED (id),
	CONSTRAINT FK_rooms_complex FOREIGN KEY (complex) REFERENCES complexes(id),
	CONSTRAINT UK_rooms_number UNIQUE (room_number)
);

INSERT INTO rooms (complex, room_number, seats)
VALUES 
(1, 1, 50),
(1, 2, 100),
(1, 3, 80),
(2, 4, 50);

IF OBJECT_ID(N'movies') IS NULL
CREATE TABLE movies 
(
	movie_id INT IDENTITY(1,1) NOT NULL,
	CONSTRAINT PK_movies_id PRIMARY KEY CLUSTERED (movie_id)

);

IF OBJECT_ID(N'customers') IS NULL
CREATE TABLE customers 
(
	customer_id INT IDENTITY(1,1) NOT NULL,
	customer_name VARCHAR(100) NOT NULL,
	firstname VARCHAR(100) NOT NULL,
	age INT NOT NULL,
	adress VARCHAR(MAX) NOT NULL,
	email VARCHAR(MAX) NOT NULL,
	phone_number CHAR(10) NOT NULL,
	CONSTRAINT PK_customers_id PRIMARY KEY CLUSTERED (customer_id)
);

IF OBJECT_ID(N'payments') IS NULL
CREATE TABLE payments 
(
	payment_id INT IDENTITY(1,1) NOT NULL,
	CONSTRAINT PK_payments_id PRIMARY KEY CLUSTERED (payment_id)

);

IF OBJECT_ID(N'reservations') IS NULL
CREATE TABLE reservations 
(
    reservation_id INT IDENTITY(1,1) NOT NULL,
	customer_id INT NOT NULL,
	movie_id INT NOT NULL,
	payment_id INT NOT NULL,
	CONSTRAINT PK_reservations_id PRIMARY KEY CLUSTERED (reservation_id),
	CONSTRAINT FK_customers_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	CONSTRAINT FK_movies_id FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
	CONSTRAINT FK_payments_id FOREIGN KEY (payment_id) REFERENCES payments(payment_id)
);

--DROP TABLE rooms;
--DROP TABLE payments;
--DROP TABLE customers;
--DROP TABLE movies;
--DROP TABLE reservations;
--DROP DATABASE cinema_booking_app;

