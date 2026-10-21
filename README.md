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


## With items AS ( Select order_id, Count(*) AS n_items, Sum(price) AS items_revenue
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

![Executive Overview](Executive_Overview.png)




Executive Overview:


What it Shows: Monthly Revenue, Top Product Categories, Revenue by State
1. In the line chart Revenue by Month the revenue only grows after January 2017 peaking through about 1M by late November 2017 and held between 0.8M to 0.9M
   in 2018 through August.
2. In Column Chart top categories growth sales such as Health-beauty, Watches-gifts, bed-bath table, sports leisure being the top through all three years:
   
   In 2016 Health Beauty 450K sales, Watches-gifts 3.4k, sports leisure 3.3k
   
   In 2017 Health Beauty 0.48M sales, Watches-gifts 0.50M, sports leisure 0.45M, Bed_bath_table 0.55M
   
   In 2018 Health Beauty 0.77M sales, Watches-gifts 0.71M, sports leisure 0.53M, Bed_bath_table 0.54M
   
3. In Table view Sao Paulo being the top leading state in revenue with a total of 38% revenue.
 
4. The Avg Review Score includes DAX measure of review_score column, Avg Order value includes division between revenue and orders.



Customer Insights


![Customer Insight](Customer_Insight.png)









