| Table | High-Usage Columns | Reason
--------|--------------------| -------
`Property` | `property_id` | Use in `JOIN`, `ORDER BY`, subqueries|
`Booking` | `property_id`, `user_id`, `booking_id` | Used in JOIN, subqueries, `COUNT`, filtering |
`User` | `user_id` | Typically used in `JOIN`s and lookups |