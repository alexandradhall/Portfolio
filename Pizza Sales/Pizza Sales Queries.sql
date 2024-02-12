--Raw data can be found in pizza_sales.csv

--KPIs
--Total Revenue
SELECT SUM(total_price) As Total_Revenue
FROM pizza_sales;

--Average Order Value
SELECT SUM(total_price)/COUNT(DISTINCT order_id) As Average_Order_Value
From pizza_sales;

--Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales

--Total Orders
SELECT COUNT(DISTINCT order_id) As Total_Orders
FROM pizza_sales

--Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id)As decimal(10,2)) AS decimal(10,2)) As Average_Pizzas_per_Order
FROM pizza_sales

--Charts

--Daily Trend of Total Orders
SELECT DATENAME(DW, order_date) as Order_Day, COUNT(DISTINCT order_id) As Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

--Monthly Trend of Total Orders
SELECT DATENAME(MONTH, order_date) as Month_Name, COUNT(DISTINCT order_id) As Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC

--Percentage of Sales by Pizza Category
SELECT pizza_category, SUM(total_price) * 100 / (SELECT sum(total_Price) from pizza_sales) As PercentofTotalSales
FROM pizza_sales
GROUP BY pizza_category
--Percentage of Sales by Category and month
SELECT pizza_category, SUM(total_price) * 100 / (SELECT sum(total_Price) from pizza_sales WHERE MONTH(order_date) = 1) As PercentofTotalSales
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

--Percentage of sales by size
SELECT pizza_size, CAST(SUM(total_price) * 100 / (SELECT sum(total_Price) from pizza_sales) AS decimal(10,2)) As PercentofTotalSales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PercentofTotalSales DESC
--Percentage of sales by size and Quarter
SELECT pizza_size, CAST(SUM(total_price) * 100 / (SELECT sum(total_Price) from pizza_sales WHERE DATEPART(QUARTER, order_date)=1) AS decimal(10,2)) As PercentofTotalSales
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date)=1
GROUP BY pizza_size
ORDER BY PercentofTotalSales DESC

--Top 5 best sellers by Revenue, Total Quantity and Total Orders
SELECT TOP 5 pizza_name, SUM(total_price) As Total_Revenue
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Revenue DESC

SELECT TOP 5 pizza_name, SUM(quantity) As Total_Quantity
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Quantity DESC

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) As Total_Order
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Order DESC

--Top 5 Worst sellers by Revenue, Total Quantity and Total Orders
SELECT TOP 5 pizza_name, SUM(total_price) As Total_Revenue
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Revenue ASC

SELECT TOP 5 pizza_name, SUM(quantity) As Total_Quantity
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Quantity ASC

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) As Total_Order
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Order ASC