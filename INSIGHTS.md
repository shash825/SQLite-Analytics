# INSIGHTS — SQLite Coding Challenge

Findings from running the four tasks in `challenge.sql` against `bais_sqlite_lab.db`. All revenue figures come from summing `order_items.quantity * order_items.unit_price`.

## Customer spend (Task 1)

- **Jacob Foster leads lifetime spend at $8,722.67**, followed closely by Ethan Gomez at $8,206.19. Together these two account for roughly 44% of all revenue in the database.
- **The top 5 customers generated $31,248.51, about 80.5% of total revenue ($38,801.19)**. With only 10 customers in the table, the concentration is extreme but not surprising for a small sample.

## Category revenue (Task 2)

- **Electronics dominates at 65.4% of total revenue ($25,364.23)**. Furniture is a distant second at 32.8% ($12,712.00). Grocery and Stationery combined contribute under 2%.
- **Restricting to Delivered orders drops total revenue to $22,772.65, roughly 58.7% of the all-orders figure.** The category ranking stays identical, but Electronics' share drops to 59.8% while Furniture's rises to 38.4%, suggesting a larger portion of Electronics orders are still Pending, Shipped, or Cancelled.
- **Order status distribution:** 30 Delivered, 13 Shipped, 4 Pending, 3 Cancelled. Only 60% of orders have actually made it to the customer, so revenue recognition timing matters if this were a real finance report.

## Employee compensation (Task 3)

- **Exactly one employee in each of the five departments earns above their department average.** That clean 1-per-department pattern suggests small department sizes (likely 2 to 3 employees each) where one clear top earner pulls the average up.
- **Maya Bennett (IT, $112,000) is the largest absolute outlier**, sitting $6,667 above her department's $105,333 average. Alice Nguyen (Sales, $72,000) has the largest gap proportionally, at $11,000 above a $61,000 average (+18%).

## Loyalty geography (Task 4)

- **Tampa holds all 4 Gold customers and accounts for 40% of the entire customer base.** No other city has a single Gold customer.
- **Every non-Tampa city has exactly one customer**, split across Silver (Brandon, Sarasota, St. Petersburg) and Bronze (Clearwater, Lakeland, Orlando). The business is heavily Tampa-concentrated with thin, uniform representation elsewhere in the region.
- **Strategic takeaway:** Tampa is functionally the home market. Any churn in those four Gold customers would have an outsized effect on revenue, while the other cities represent untapped growth potential rather than meaningful current contribution.

## Notes on methodology

- Task 1 does not filter by order status, per the brief. If only Delivered orders were counted, the leaderboard could shift since we know 40% of orders are in non-Delivered states.
- Task 3 uses a subquery computing per-department averages joined back to each employee row, which is the standard SQLite-friendly pattern since SQLite supports window functions but the subquery approach reads more clearly here.