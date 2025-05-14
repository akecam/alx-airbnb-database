-- -------------------------
-- Advanced Querying Power
-- -------------------------
-- Author: Donald Umeh
-- -------------------------


-- ------------------------
-- INNER JOIN
-- ------------------------

SELECT * FROM
	`Booking` 
INNER JOIN 
	`User`
ON
	`User`.user_id = `Booking`.user_id;


-- ------------------------
-- LEFT JOIN
-- ------------------------

SELECT * FROM
	`Property`
LEFT JOIN
	`Review`
ON
	`Property`.property_id = `Review`.property_id;


-- ------------------------
-- FULL OUTER JOIN
-- ------------------------

SELECT * FROM
	`Booking`
LEFT JOIN
	`User`
ON
	`User`.user_id = `Booking`.user_id

UNION

SELECT * FROM 
	`Booking`
RIGHT JOIN
	`User`
ON
	`User`.user_id = `User`.user_id;

