-- -------------------------
-- Advanced Querying Power
-- -------------------------
-- Author: Donald Umeh
-- -------------------------

-- ------------------------
-- Find all properties where the average 
-- rating is greater than 4.0
-- -------------------------

SELECT * FROM
	`Property`
WHERE (SELECT AVG(rating) FROM `Review`
			WHERE 
				`Property`.property_id = `Review`.property_id)
	> 4.0;


-- ------------------------
-- Correlated subquery to find users 
-- who have made more than 3 bookings
-- ------------------------

SELECT * FROM
	`User`
WHERE
	(SELECT COUNT(user_id) FROM `Booking`
	 WHERE
	 	`User`.user_id = `Booking`.user_id) > 3;
