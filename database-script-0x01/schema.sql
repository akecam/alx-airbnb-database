-- ---------------------------------------
-- Database Design for Airbnb Project
-- --------------------------------------
-- Author
-- Donald Umeh (donaldumeh54@gmail.com)
-- --------------------------------------

-- --------------------------------------
-- DROP DATABASE IF NOT EXISTENT
-- --------------------------------------

DROP DATABASE IF EXISTS `alx-airbnb-database`;

-- --------------------------------------
-- CREATE DATABASE IF NOT EXISTENT
-- --------------------------------------
CREATE DATABASE IF NOT EXISTS `alx-airbnb-database`;

USE `alx-airbnb-database`;


-- --------------------------------------
-- CREATE `User` Table
-- --------------------------------------

CREATE TABLE IF NOT EXISTS `User` (
    user_id CHAR(36) PRIMARY KEY,
    first_name VARCHAR(90) NOT NULL,
    last_name VARCHAR(90) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NULL,
    role ENUM('guest', 'host', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


-- --------------------------------------
-- CREATE `Property` Table
-- --------------------------------------

CREATE TABLE IF NOT EXISTS `Property` (
    property_id CHAR(36) PRIMARY KEY,
    host_id CHAR(36) NOT NULL,
    name VARCHAR(90) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Foreign Key Constraint
    CONSTRAINT fk_property_host
        FOREIGN KEY (host_id)
        REFERENCES `User`(user_id)
        ON DELETE CASCADE
) ENGINE=InnoDB;


-- --------------------------------------
-- CREATE `Booking` Table
-- --------------------------------------

CREATE TABLE IF NOT EXISTS `Booking` (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_booking_property
        FOREIGN KEY (property_id)
        REFERENCES  `Property`(property_id)
        ON DELETE CASCADE,
    
    CONSTRAINT fk_booking_user
        FOREIGN KEY (user_id)
        REFERENCES `User`(user_id)
        ON DELETE CASCADE
) ENGINE=InnoDB;



-- --------------------------------------
-- CREATE `Payment` Table
-- --------------------------------------

CREATE TABLE IF NOT EXISTS `Payment` (
    payment_id CHAR(36) PRIMARY KEY,
    booking_id CHAR(36) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,


    CONSTRAINT fk_payment_booking
        FOREIGN KEY (booking_id)
        REFERENCES `Booking`(booking_id)
        ON DELETE CASCADE
) ENGINE=InnoDB;


-- --------------------------------------
-- CREATE `Review` Table
-- --------------------------------------

CREATE TABLE IF NOT EXISTS `Review` (
    review_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    rating INT NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_rating
        CHECK (rating BETWEEN 1 AND 5), -- (rating >= 1 AND rating <= 5),

    CONSTRAINT fk_review_user
        FOREIGN KEY (user_id)
        REFERENCES `User`(user_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_review_property
        FOREIGN KEY (property_id)
        REFERENCES `Property`(property_id)
        ON DELETE CASCADE
) ENGINE=InnoDB;



-- --------------------------------------
-- CREATE `Message` Table
-- --------------------------------------

CREATE TABLE IF NOT EXISTS `Message` (
    message_id CHAR(36) PRIMARY KEY,
    sender_id CHAR(36) NOT NULL,
    recipient_id CHAR(36) NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_message_recipient
        FOREIGN KEY (recipient_id)
        REFERENCES `User`(user_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_message_sender
        FOREIGN KEY (sender_id)
        REFERENCES `User`(user_id)
        ON DELETE CASCADE
) ENGINE=InnoDB;



