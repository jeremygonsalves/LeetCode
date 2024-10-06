
WITH ranked_orders AS (
    SELECT 
        customer_id, 
        order_date, 
        customer_pref_delivery_date,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date ASC) AS rn
    FROM Delivery
),
first_orders AS (
    SELECT 
        customer_id, 
        order_date, 
        customer_pref_delivery_date,
        CASE 
            WHEN customer_pref_delivery_date = order_date THEN 'immediate'
            ELSE 'scheduled'
        END AS delivery_type
    FROM ranked_orders
    WHERE rn = 1  -- Filter to get only the first order for each customer
)
SELECT 
    ROUND(100 * SUM(CASE WHEN delivery_type = 'immediate' THEN 1 ELSE 0 END) / COUNT(*), 2) AS immediate_percentage
FROM first_orders;
