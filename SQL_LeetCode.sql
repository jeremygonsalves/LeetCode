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
