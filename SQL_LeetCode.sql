--Leet Code Problem 1
Select product_id from Products
where low_fats='Y' AND recyclable='Y'


--Leet Code Problem 2
select date_format(trans_date, '%Y-%m') as month
    , country
    ,count(*) as trans_count
    ,sum(state='approved') as approved_count
    ,sum(amount) as trans_total_amount
    ,sum((state='approved') *amount) as approved_total_amount
from Transactions
group by 1,2;


--select employees who have a manager ID
select employee_id from employees
where salary < 30000 and manager_id not in (select employee_id from employees)
order by 1;



--swap seats of every second id
Select
id,
CASE WHEN id % 2 = 0 THEN LAG(student) OVER(ORDER BY id)
    ELSE COALESCE(LEAD(student) over(ORDER BY id), student)
END AS student
FROM seat


--select the top user with ratings, the top movie in Feb
--*************************--
-- Find the user who has rated the greatest number of movies
WITH UserRatings AS (
    SELECT mr.user_id, COUNT(*) AS rating_count
    FROM MovieRating mr
    GROUP BY mr.user_id
),
TopUser AS (
    SELECT u.name
    FROM UserRatings ur
    JOIN Users u ON ur.user_id = u.user_id
    ORDER BY ur.rating_count DESC, u.name ASC
    LIMIT 1
),

-- Find the movie with the highest average rating in February 2020
MovieAvgRating AS (
    SELECT mr.movie_id, AVG(mr.rating) AS avg_rating
    FROM MovieRating mr
    WHERE mr.created_at BETWEEN '2020-02-01' AND '2020-02-29'
    GROUP BY mr.movie_id
),
TopMovie AS (
    SELECT m.title
    FROM MovieAvgRating mar
    JOIN Movies m ON mar.movie_id = m.movie_id
    ORDER BY mar.avg_rating DESC, m.title ASC
    LIMIT 1
)

-- Final result
SELECT name as results 
FROM TopUser
UNION ALL
SELECT title FROM TopMovie;




--LEet CODE PROBLEM 1174. Immediate Food Delivery II--

WITH ranked_orders AS (
    SELECT 
        customer_id, 
        order_date, 
        customer_pref_delivery_date,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn
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
