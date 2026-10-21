# Ecommerce Sales & Customer Retention Analytics
An end-to-end analysis about 100K+ orders from a Brazilian Online Marketing dataset(Olist 2016 - 2018). I modelled the raw data into Snowflake with SQL and bulit a 3-page dashboard in Power BI answering revenue, customer retention, delivery performance.


## Tools Used: Snowflake, SQL, Power BI(DAX)

## Dataset: 9 tables including customers, orders, payments, review score, items, product & sellers details.


## Approach: I'm going to answer a few Business Questions from my analysis showcasing charts and sql snippets.


         1. How the revenue is growing and which categories and region helps drive it?
         
         2. Do customers come back after their first order?
         
         3. Which customers are worth the most and who is at worth a shot for winning back?
         
         4. Do late deliveries hurt customer satisfaction?
         
<details>
  <summary> Building one row per order without inflating revenue </summary>
 <summary> Orders can have several items and payments regarding it. Joining the tables directly would multiply rows and overcount revenue, so first aggregating one row per order. </summary>
</details>
