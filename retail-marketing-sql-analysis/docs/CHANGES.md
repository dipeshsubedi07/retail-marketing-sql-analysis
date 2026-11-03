# Portfolio preparation and validation

## Changes from the original submission

- Split the SQL into database setup and analytical queries; changed the database name to `retail_marketing_portfolio`.
- Preserved the original eight-table design and dummy records. Changed dummy SQL email domains to `example.com`.
- Query 2: replaced the customer-only order join with an explicit same-day, single-click attribution illustration, preventing multiple assignment of an order. Added zero-activity campaigns and renamed the misleading ROI metric.
- Query 3: renamed the metric to clicks per advertisement and included all platforms. Protected division by zero.
- Query 5: renamed revenue based on current catalogue prices to `CatalogueValue`.
- Query 7: used DISTINCT event counts and LEFT JOINs to prevent multiplication and include customers without clicks. Added Under 18 and Unknown age labels.
- Queries 1, 4 and 6 retain their analytical logic.
- Removed the student ID from the original report and its PDF metadata. The report's remaining content and embedded screenshots are historical and may differ from the corrected files.
- Kept the original ERD image. Excluded the assessment brief and operating-system archive files.

## Checks completed

The setup and seven analysis queries were executed in an in-memory SQLite database with foreign-key enforcement, removing only MySQL database-selection statements for the check. There were no foreign-key violations.

Campaign output reconciled to all 30 supplied orders and their total revenue. Age-group output reconciled to 30 clicks and 30 orders. A further check inserted a second click on an existing customer's purchase date: campaign order assignments remained at 30, while age-group counts became 31 clicks and 30 orders. This verifies that repeated clicks no longer multiply orders.

The student ID was checked absent from extracted PDF text; the modified cover page was rendered and inspected. The ERD was visually reviewed. CSV outputs reflect the original supplied dummy data, not the extra validation click.

MySQL itself was unavailable, so native MySQL execution is not claimed. Run both scripts in MySQL Workbench for environment-specific verification.
