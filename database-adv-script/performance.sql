-- ------------------------
-- Author: Donald Umeh
-- donaldumeh54@gmail.com
-- ------------------------


-- Database has over 5000 rows on each table

-- Analyze the tables first

ANALYZE TABLE Booking;
ANALYZE TABLE User;
ANALYZE TABLE Property;
ANALYZE TABLE Payment;

-- SET profiling (Although deprecated,
-- it shows the runtime of each query)
SET profiling = 1;

-- Initial query to retrieves all bookings along with 
-- user details, property details, and payment details

SELECT 
    * 
FROM 
    Booking
JOIN
    User ON
        User.user_id = Booking.user_id
JOIN
    Property ON
        Property.property_id = Booking.property_id
JOIN
    Payment ON
        Payment.booking_id = Booking.booking_id;

--  Show profile(s) check runtime
SHOW PROFILES;
SHOW PROFILE;


-- Check analyzes of running the query considering InnoDB In-built Cache

EXPLAIN ANALYZE
SELECT 
    * 
FROM 
    Booking
JOIN
    User ON
        User.user_id = Booking.user_id
JOIN
    Property ON
        Property.property_id = Booking.property_id
JOIN
    Payment ON
        Payment.booking_id = Booking.booking_id
WHERE 
    Property.pricepernight < 1000.00;

-- Check Estimates time it took to loop through the table in the tree and
-- create index where needed

-- Indexes for the Property table
CREATE INDEX idx_property_id ON Property(property_id);

-- Indexes for the Booking table
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_id ON Booking(booking_id);

-- Indexes for the User table
CREATE INDEX idx_user_id ON User(user_id);
