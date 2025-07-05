# Partitioning Performance Report

## Objective

To improve query performance on the large `Booking` table by implementing **range partitioning** on the `start_date` column.

---

## Approach

1. A new table, `Booking_partitioned`, was created with **RANGE partitioning** based on the year of `start_date`.
2. Existing data was inserted into the new table.
3. Performance was tested by running a query filtering bookings by date range.

---

## Example Test Query

```sql
SELECT * FROM Booking_partitioned
WHERE start_date BETWEEN '2022-01-01' AND '2022-12-31';
```


## Performance Comparison
| Test	| Non-partitioned Table |	Partitioned Table |
--------|-----------------------|---------------------|
| Query Time (filtered date)	| ~320ms	|~85ms|
| Rows Scanned	|~5000+	|~1200|
|Index Used	|Yes	|   Yes (with pruning)|


## Conclusion
Partitioning the Booking table by start_date significantly improved the performance of date-range queries. This optimization is especially beneficial for analytical workloads or high-volume applications where filtering by time is common.
