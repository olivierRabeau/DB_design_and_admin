--Requires to be connected with "sa" login 
--or USR_administrator if database has been migrated to partially contained

--File used to display tables and views

USE cinema_booking_db
GO

DECLARE @nb_rows INT = 5

SELECT TOP(@nb_rows) * FROM S_management.T_rooms;
SELECT TOP(@nb_rows) * FROM S_management.T_roles;
SELECT TOP(@nb_rows) * FROM S_management.T_employees;
SELECT TOP(@nb_rows) * FROM S_programming.T_movies;
SELECT TOP(@nb_rows) * FROM S_programming.T_movies_screenings;
SELECT TOP(@nb_rows) * FROM S_accounting.T_prices;
SELECT TOP(@nb_rows) * FROM S_accounting.T_reductions;
SELECT TOP(@nb_rows) * FROM S_reception.T_customers;
SELECT TOP(@nb_rows) * FROM S_reception.T_reservations;
SELECT TOP(@nb_rows) * FROM S_accounting.T_invoices;
SELECT TOP(@nb_rows) * FROM S_reception.V_reservations;
SELECT TOP(@nb_rows) * FROM S_reception.V_availables_seats
SELECT TOP(@nb_rows) * FROM S_accounting.V_invoices;
SELECT TOP(@nb_rows) * FROM S_management.V_complexes_stats;
SELECT TOP(@nb_rows) * FROM S_programming.V_movies_stats;