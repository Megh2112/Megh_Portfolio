# Ecommerce Sales & Customer Retention Analytics
An end-to-end analysis about 100K+ orders from a Brazilian Online Marketing dataset(Olist 2016 - 2018). I modeled the raw data into Snowflake with SQL and built a 3-page dashboard in Power BI answering revenue, customer retention, delivery performance.


 Tools Used: Snowflake, SQL, Power BI(DAX)

 Dataset: 9 tables including customers, orders, payments, review score, items, product & sellers details.

 Approach: I'm going to answer a few Business Questions from my analysis showcasing charts and sql snippets.


         1. How the revenue is growing and which categories and region helps drive it?
         
         2. Do customers come back after their first order?
         
         3. Which customers are worth the most and who is at worth a shot for winning back?
         
         4. Do late deliveries hurt customer satisfaction?
         
<details>
  <summary> Building one row per order without inflating revenue </summary>
 <summary> Orders can have several items and payments regarding it. Joining the tables directly would multiply rows and overcount revenue, so first aggregating one row per order. </summary>
 
 ```SQL


 With items AS ( Select order_id, Count(*) AS n_items, Sum(price) AS items_revenue
                From order_items
                Group by order_id ),


 ( Select order_id, Sum(payment_value) AS payment_total
  from order_payments
  Group by order_id )


  Select o.order_id, c.customer_unique_id, i.items_revenue, p.payment_total
  DATEDIFF (o.order_purchase_timestamp, o.order_delivered_customer_date) AS delivery_days
  From orders o
  Join customers c ON o.customer_id = c.customer_id
  Left Join items i ON o.order_id = i.order_id
 Left Join payments p ON o.order_id = p.order_id;

```
</details>

![Image alt](https://github.com/Megh2112/Megh_Portfolio/blob/cdc9928e8a17d073352691f1206c5f9d0b344948/Executive_Overview_page.png)



