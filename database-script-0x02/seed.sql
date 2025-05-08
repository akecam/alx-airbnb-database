-- Database Insertion scripts


-- Insert Sample Users

INSERT INTO `User` (`user_id`, `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`) VALUES
('u001', 'Alice', 'Johnson', 'alice@example.com', 'hash1', '1234567890', 'guest', NOW()),
('u002', 'Bob', 'Smith', 'bob@example.com', 'hash2', '2345678901', 'host', NOW()),
('u003', 'Charlie', 'Brown', 'charlie@example.com', 'hash3', '3456789012', 'guest', NOW()),
('u004', 'Diana', 'Prince', 'diana@example.com', 'hash4', '4567890123', 'host', NOW());


-- Insert Sample Properties

INSERT INTO `Property` (`property_id`, `host_id`, `name`, `description`, `location`, `pricepernight`, `created_at`, `updated_at`) VALUES
('p001', 'u002', 'Cozy Cabin', 'A warm and cozy mountain cabin.', 'Denver, CO', 120.00, NOW(), NOW()),
('p002', 'u004', 'Beach House', 'Sunny beachside retreat.', 'Malibu, CA', 300.00, NOW(), NOW());


-- Insert Sample Bookings

INSERT INTO `Booking` (`booking_id`, `property_id`, `user_id`, `start_date`, `end_date`, `total_price`, `status`, `created_at`) VALUES
('b001', 'p001', 'u001', '2025-06-01', '2025-06-05', 480.00, 'confirmed', NOW()),
('b002', 'p002', 'u003', '2025-07-10', '2025-07-12', 600.00, 'pending', NOW());


-- Insert Sample Payments

INSERT INTO `Payment` (`payment_id`, `booking_id`, `amount`, `payment_date`, `payment_method`) VALUES
('pay001', 'b001', 480.00, NOW(), 'credit_card'),
('pay002', 'b002', 600.00, NOW(), 'paypal');


-- Insert Sample Reviews

INSERT INTO `Review` (`review_id`, `property_id`, `user_id`, `rating`, `comment`, `created_at`) VALUES
('r001', 'p001', 'u001', 5, 'Amazing experience. Will come again!', NOW()),
('r002', 'p002', 'u003', 4, 'Nice location but noisy neighbors.', NOW());



