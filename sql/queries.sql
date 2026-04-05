-- insights we need to find out

-- 1. a monthly revenue trend
-- 2. best selling categories
-- 3. customer retention rate (repeat purchase)
-- 4. delivery time vs review score

-- Solution

-- 1. a monthly revenue trend
SELECT
	DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01') AS month,
    SUM(p.payment_value) AS revenue
FROM orders AS o
JOIN payments AS p
ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;
--

-- 2. best selling categories
SELECT
	pr.product_category_name AS category,
    COUNT(oi.order_id) AS total_orders
FROM order_items AS oi
JOIN products AS pr
ON oi.product_id = pr.product_id
GROUP By category
ORDER BY total_orders DESC
LIMIT 10;
--

-- 3. customer retention rate (repeat purchase)
SELECT 
    customer_id,
    COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;
--

-- 4. delivery time vs review score
SELECT 
    r.review_score,
    AVG(TIMESTAMPDIFF(DAY, 
        o.order_purchase_timestamp, 
        o.order_delivered_customer_date
    )) AS avg_delivery_time_days
FROM orders o
JOIN reviews r 
    ON o.order_id = r.order_id
GROUP BY r.review_score
ORDER BY r.review_score;
--

SELECT * FROM orders;