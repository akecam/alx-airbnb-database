# SQL Performance Analysis and Optimization

**Author**: Donald Umeh  
**Email**: donaldumeh54@gmail.com  

> **Note**: The database contains over 5000 rows in each table.

---

## 📊 Step 1: Analyze Tables

Start by collecting statistics on the tables. This helps the query optimizer make better decisions.

```sql
ANALYZE TABLE Booking;
ANALYZE TABLE User;
ANALYZE TABLE Property;
ANALYZE TABLE Payment;
```

## ⏱ Step 2: Enable Profiling
Although deprecated, SET profiling = 1 still provides runtime details for queries in some MySQL versions.

```sql
SET profiling = 1;
```

## 🧾 Step 3: Run Initial Query
Fetch all bookings along with associated user, property, and payment details.

```sql
SELECT 
    * 
FROM 
    Booking
JOIN
    User ON User.user_id = Booking.user_id
JOIN
    Property ON Property.property_id = Booking.property_id
JOIN
    Payment ON Payment.booking_id = Booking.booking_id;
```


## 📋 Step 4: Show Query Profile
Use these commands to check the runtime performance of the above query.

```sql
SHOW PROFILES;
SHOW PROFILE;
```

## 🧠 Step 5: Use EXPLAIN ANALYZE for Query Plan
Evaluate how the query planner executes the query, including caching effects (e.g., InnoDB buffer pool).

```sql
EXPLAIN ANALYZE
SELECT 
    * 
FROM 
    Booking
JOIN
    User ON User.user_id = Booking.user_id
JOIN
    Property ON Property.property_id = Booking.property_id
JOIN
    Payment ON Payment.booking_id = Booking.booking_id
WHERE 
    Property.pricepernight < 1000.00;

```

## 🏗 Step 6: Create Useful Indexes
To optimize performance, especially for joins and filters, create the following indexes:

🔍 Indexes for Property table

```sql
CREATE INDEX idx_property_id ON Property(property_id);
```

🔍 Indexes for Booking table

```sql
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_id ON Booking(booking_id);
```

🔍 Indexes for User table

```sql
CREATE INDEX idx_user_id ON User(user_id);
```

## ✅ Summary
    * Tables were analyzed to help the optimizer.
    * Profiling and EXPLAIN ANALYZE were used to inspect query performance.
    * Strategic indexes were added to improve join efficiency and filtering.
