-- Step 1: Create a new partitioned table based on start_date

CREATE TABLE Booking_partitioned (
    booking_id INT NOT NULL,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(50),
    PRIMARY KEY (booking_id, start_date)
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);

-- Step 2: Insert data from the original Booking table
INSERT INTO Booking_partitioned
SELECT * FROM Booking;

-- Optional: Test query performance (example query)
SELECT * FROM Booking_partitioned
WHERE start_date BETWEEN '2022-01-01' AND '2022-12-31';
