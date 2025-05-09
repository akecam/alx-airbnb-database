-- --------------------------------------
-- Database seeding for my Airbnb Project
-- --------------------------------------
-- Author
-- Donald Umeh (donaldumeh54@gmail.com)
-- --------------------------------------


-- --------------------------------------
-- MAKE USE OF THE DATABASE IN DBMS
-- --------------------------------------

USE `alx-airbnb-database`;


-- -------------------------------------
-- Inserting into `User` Entity
-- -------------------------------------

INSERT INTO `User` (user_id, first_name, last_name, email, password_hash, phone_number, role)
	VALUES
		("U001", "Daniel", "Jona", "daniel.joha@email.com", "password_hash", "+2349189092029", "guest"),
		("U002", "Stephen", "Desire", "stephen.desire@email.com", "password_hash2", "+234989109202", "host"),
		("U003", "Samuel", "Destiny", "samuel.destiny@email.com", "password_hash3", "+234908189389", "admin"),
		("U004", "Joshua", "Biodun", "joshua.biodun@email.com", "password_hash4", "+2348910929033", "host");


-- -------------------------------------
-- Inserting into `Property` Entity
-- -------------------------------------

INSERT INTO `Property` (property_id, host_id, name, description, location, pricepernight)
	VALUES
		("P001", "U002", "Duplex 4 bedroom", "Just a regular bedroom apartment", "Texas", 40.50),
		("P002", "U002", "Condo Apartment", "Just another regualr bedroom apartment", "Houston", 100.20),
		("P003", "U004", "Semi Duplex", "Just a regualr bedroom apartment", "Manhattan, New York", 430.90),
		("P004", "U004", "4 bedroom apartment", "Just a regualr bedroom apartment", "Manhattan, New York", 300.00);



-- ------------------------------------
-- Inserting into `Booking` entity
-- ------------------------------------

INSERT INTO `Booking` (booking_id, property_id, user_id, start_date, end_date, total_price, status)
	VALUES 
		("B001", "P001", "U001", "2025-01-25", "2025-02-25", 3000.45, "confirmed"),
		("B002", "P004", "U001", "2025-03-20", "2025-05-03", 9000.50, "confirmed");



-- -----------------------------------
-- Inserting into `Payment` entity
-- -----------------------------------

INSERT INTO `Payment` (payment_id, booking_id, amount, payment_method)
	VALUES
		("PT001", "B001", 3000.45, "stripe"),
		("PT002", "B002", 9000.50, "paypal");



-- ----------------------------------
-- Inserting into Review
-- ----------------------------------

INSERT INTO `Review` (review_id, property_id, user_id, rating, comment)
	VALUES
		("R001", "P001", "U001", 3, "I enjoyed my stay there"),
		("R002", "P004", "U001", 4, "It was the best place to stay at in New York. They had free internet and cleaning services were available everyday");


-- ---------------------------------
-- Inserting into `Message`
-- ---------------------------------

INSERT INTO `Message` (message_id, sender_id, recipient_id, message_body)
	VALUES
		("M001", "U001", "U002", "I would like to rent this apartment for a month"),
		("M002", "U001", "U004", "I would like to rent this apartment for 90 days. I love it!");


