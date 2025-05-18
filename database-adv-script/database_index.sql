-- Indexes for the Property table
CREATE INDEX idx_property_id ON Property(property_id);

-- Indexes for the Booking table
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_id ON Booking(booking_id);

-- Indexes for the User table
CREATE INDEX idx_user_id ON User(user_id);


-- Mesaure Query Performance
EXPLAIN ANALYZE
SELECT 
    Property.property_id AS prop_id,
    (SELECT COUNT(*) FROM Booking WHERE Booking.property_id = Property.property_id) AS sum_of_bookings
FROM Property;
