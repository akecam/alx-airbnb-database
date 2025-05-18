-- -------------------------
-- Advanced Querying Power
-- -------------------------
-- Author: Donald Umeh
-- -------------------------


-- ------------------------
-- QUERY TO FIND NUMBER OF BOOKINGS MADE BY EACH USER
-- ------------------------

SELECT first_name, 
    last_name, 
    COUNT(*) AS number_off_bookings
FROM
    User
JOIN
    Booking
ON 
    Booking.user_id = User.user_id
GROUP BY
    first_name, last_name;

-- ------------------------
-- QUERY TO RANK PROPERTIES BASED ON TOTAL NUMBER OF BOOKINGS
-- ------------------------

SELECT 
    ROW_NUMBER() OVER (ORDER BY prop_id) AS row_num,
    prop_id,
    sum_of_bookings,
    DENSE_RANK() OVER (ORDER BY sum_of_bookings DESC) AS booking_rank
FROM (
    SELECT 
        Property.property_id AS prop_id,
        (SELECT COUNT(*) 
         FROM Booking 
         WHERE Booking.property_id = Property.property_id) AS sum_of_bookings
    FROM 
        Property
) AS Sub;

