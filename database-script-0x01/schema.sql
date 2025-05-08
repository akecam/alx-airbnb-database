-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema alx-airbnb-database
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema alx-airbnb-database
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `alx-airbnb-database` ;
USE `alx-airbnb-database` ;

-- -----------------------------------------------------
-- Table `alx-airbnb-database`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alx-airbnb-database`.`User` (
  `user_id` MEDIUMTEXT NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(70) NOT NULL,
  `password_hash` VARCHAR(120) NOT NULL,
  `phone_number` VARCHAR(13) NULL,
  `role` ENUM('guest', 'host', 'admin') NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alx-airbnb-database`.`Property`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alx-airbnb-database`.`Property` (
  `property_id` MEDIUMTEXT NOT NULL,
  `host_id` MEDIUMTEXT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `description` LONGTEXT NOT NULL,
  `location` VARCHAR(50) NOT NULL,
  `pricepernight` DECIMAL NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME GENERATED ALWAYS AS (CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP),
  PRIMARY KEY (`property_id`),
  UNIQUE INDEX `property_id_UNIQUE` (`property_id` ASC) VISIBLE,
  INDEX `fk_property_user_idx` (`host_id` ASC) VISIBLE,
  CONSTRAINT `fk_property_user`
    FOREIGN KEY (`host_id`)
    REFERENCES `alx-airbnb-database`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alx-airbnb-database`.`Booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alx-airbnb-database`.`Booking` (
  `booking_id` MEDIUMTEXT NOT NULL,
  `property_id` MEDIUMTEXT NOT NULL,
  `user_id` MEDIUMTEXT NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `total_price` DECIMAL NOT NULL,
  `status` ENUM('pending', 'confirmed', 'canceled') NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`booking_id`),
  UNIQUE INDEX `booking_id_UNIQUE` (`booking_id` ASC) VISIBLE,
  INDEX `fk_booking_property1_idx` (`property_id` ASC) VISIBLE,
  INDEX `fk_booking_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_booking_property1`
    FOREIGN KEY (`property_id`)
    REFERENCES `alx-airbnb-database`.`Property` (`property_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `alx-airbnb-database`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alx-airbnb-database`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alx-airbnb-database`.`Payment` (
  `payment_id` MEDIUMTEXT NOT NULL,
  `booking_id` MEDIUMTEXT NOT NULL,
  `amount` DECIMAL NOT NULL,
  `payment_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_method` ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE INDEX `payment_id_UNIQUE` (`payment_id` ASC) VISIBLE,
  INDEX `fk_Payment_Booking1_idx` (`booking_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Booking1`
    FOREIGN KEY (`booking_id`)
    REFERENCES `alx-airbnb-database`.`Booking` (`booking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alx-airbnb-database`.`Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alx-airbnb-database`.`Review` (
  `review_id` MEDIUMTEXT NOT NULL,
  `property_id` MEDIUMTEXT NOT NULL,
  `user_id` MEDIUMTEXT NOT NULL,
  `rating` INT NOT NULL,
  `comment` LONGTEXT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`),
  UNIQUE INDEX `review_id_UNIQUE` (`review_id` ASC) VISIBLE,
  INDEX `fk_Review_Property1_idx` (`property_id` ASC) VISIBLE,
  INDEX `fk_Review_User1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `chk_rating_range` CHECK (`rating` >= 1 AND `rating` <= 5),
  CONSTRAINT `fk_Review_Property1`
    FOREIGN KEY (`property_id`)
    REFERENCES `alx-airbnb-database`.`Property` (`property_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Review_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `alx-airbnb-database`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alx-airbnb-database`.`Message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alx-airbnb-database`.`Message` (
  `message_id` MEDIUMTEXT NOT NULL,
  `sender_id` MEDIUMTEXT NOT NULL,
  `recipient_id` MEDIUMTEXT NOT NULL,
  `message_body` LONGTEXT NOT NULL,
  `sent_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`),
  INDEX `fk_Message_User1_idx` (`sender_id` ASC) VISIBLE,
  INDEX `fk_Message_User2_idx` (`recipient_id` ASC) VISIBLE,
  CONSTRAINT `fk_Message_User1`
    FOREIGN KEY (`sender_id`)
    REFERENCES `alx-airbnb-database`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Message_User2`
    FOREIGN KEY (`recipient_id`)
    REFERENCES `alx-airbnb-database`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

