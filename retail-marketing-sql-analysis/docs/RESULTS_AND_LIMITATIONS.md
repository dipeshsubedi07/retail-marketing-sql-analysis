# Corrected results and interpretation

Use the corrected SQL and CSV results as the portfolio reference. The original coursework report is retained for its database design explanation, but its old query screenshots and related numerical interpretations have not been rewritten.

## Findings

| Question | Result on the supplied dummy data | Interpretation |
| --- | --- | --- |
| Platform clicks | Instagram 8; X 5; TikTok 4 | Demonstrates a channel engagement ranking, without exposure or spend adjustment |
| Attributed campaign revenue | EOFY 1,800; Spring Collection 1,670; Black Friday 1,640 | Depends on the illustrative attribution rule below |
| Clicks per advertisement | Instagram 1.60; TikTok 1.33; X 1.25 | An ad-level activity ratio, not CTR |
| Top-spending customer | Customer 1010: 1,530 over two orders | Demonstrates customer-value ranking using order totals |
| Best-selling product | Handbag: 8 units | Units sold; the catalogue-value calculation is not realised revenue |
| Revenue by city | Sydney 4,945; Brisbane 2,115; Perth 1,625 | Order revenue, not profit |
| Age-group activity | 26–35: 16 clicks, 16 orders; 36–45: 9 and 9; 18–25: 5 and 5 | Distinct event counts, not evidence of causal conversion |

## Campaign attribution assumption

The original schema does not connect an order directly to an advertisement. Query 2 therefore uses a documented illustration: match the same customer on the same calendar date, and choose the highest ClickID if there is more than one eligible click. Each order is assigned to at most one click. Unmatched orders are not assigned to a campaign.

ClickID is a deterministic tie-breaker, not a timestamp or evidence of the last click. Date-only fields cannot establish whether a click occurred before a purchase on that day. A production design would need timestamps, a defined attribution window and a justified attribution model. All 30 supplied orders happen to match the illustration, so this sample does not show realistic unmatched traffic.

## Metric boundaries

- The schema has no impressions. It cannot calculate true click-through rate from clicks divided by impressions. The assignment brief also conflates clicking and purchasing; the portfolio uses literal metric names to avoid that ambiguity.
- Campaign budget is not actual advertising spend. Attributed revenue divided by budget is labelled `RevenueToBudgetPercent`; it is not ROI, profit or realised return on ad spend.
- Product catalogue prices are not historical transaction prices. Quantity multiplied by catalogue price is labelled `CatalogueValue`. It may not reconcile with order totals; the schema does not store line-level selling prices or discounts.
- Age-group clicks and orders are counted independently with DISTINCT to prevent join multiplication. Equal counts do not prove that clicks caused orders.
- Higher revenue alone does not establish higher profitability. The database has no cost-of-goods or profit measures.

## Design limitations and next steps

Use actual impression and spend records, explicit order attribution and event timestamps before claiming marketing effectiveness. Add historical line prices and reconcile order totals to line items. Add appropriate range checks and NOT NULL constraints; the original ERD's intended mandatory relationships are not all enforced by the nullable foreign keys. Query 1 lists channels with clicks only; Query 3 also includes channels with no ads or clicks, returning NULL clicks-per-ad when there are no ads.
