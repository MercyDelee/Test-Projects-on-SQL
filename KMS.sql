Create database DSA_Project

------------DSA Data Analysis Capstone Project
USE DSA_Project;

SELECT *
INTO KMS
FROM COC_db.dbo.KMS;


--- Case Study 2: Kultra Mega Stores Inventory
select * from KMS
---Case Scenario I
--- 1. Which product category had the highest sales?
SELECT TOP 1 Product_Category, SUM(Sales) AS Total_Sales
FROM KMS
GROUP BY Product_Category
ORDER BY Total_Sales DESC;

--- 2. What are the Top 3 and Bottom 3 regions in terms of sales?
------ Top 3
SELECT TOP 3 Region, SUM(Sales) AS Total_Sales
FROM KMS
GROUP BY Region
ORDER BY Total_Sales DESC;

---------Bottom 3
SELECT TOP 3 Region, SUM(Sales) AS Total_Sales
FROM KMS
GROUP BY Region
ORDER BY Total_Sales ASC;


------------ 3. What were the total sales of appliances in Ontario?
SELECT 
    SUM(Sales) AS Total_Appliance_Sales_Ontario
FROM 
    KMS
WHERE 
    Product_Category = 'Appliances'
    AND Province = 'Ontario';


	------------ 4. Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers
	---------- Identify the bottom 10 Customers
	SELECT TOP 10 
    Customer_Name, 
    SUM(Sales) AS Total_Sales
FROM 
    KMS
GROUP BY 
    Customer_Name
ORDER BY 
    Total_Sales ASC;
	
/*
KMS Revenue Strategy: Reviving Sales from Bottom 10 Customers

Objective:
To provide practical steps KMS can take to improve revenue from our 10 least active customers.

Key Recommendations:
- Understand Their Profile: location, segment, past purchases.
- Offer Simple Incentives: discounts, loyalty perks.
- Follow Up Personally: direct outreach to re-engage with them.
- Recommend Smartly: show affordable, relevant products.
- Make It Easy: improve delivery and checkout experience.

Conclusion:
With a bit of focused effort, these low-spending customers can be reactivated into valuable long-term buyers.
*/


	------------ 5. KMS incurred the most shipping cost using which shipping method?
	SELECT TOP 1 
    Ship_Mode, 
    SUM(Shipping_Cost) AS Total_Shipping_Cost
FROM 
    KMS
GROUP BY 
    Ship_Mode
ORDER BY 
    Total_Shipping_Cost DESC;

	------------ Case Scenario II
	--------6. Who are the most valuable customers, and what products or services do they typically purchase?

	SELECT TOP 5 
    Customer_Name, 
    SUM(Sales) AS Total_Sales
FROM 
    KMS
GROUP BY 
    Customer_Name
ORDER BY 
    Total_Sales DESC;

		-------what products or services do they typically purchase?


	SELECT 
    Customer_Name,
    Product_Name,
    COUNT(*) AS Purchase_Count,
    SUM(Sales) AS Total_Spent
FROM 
    KMS
WHERE 
    Customer_Name IN (
        SELECT TOP 5 Customer_Name
        FROM KMS
        GROUP BY Customer_Name
        ORDER BY SUM(Sales) DESC
    )
GROUP BY 
    Customer_Name, Product_Name
ORDER BY 
    Customer_Name, Total_Spent DESC;

	------------7. Which small business customer had the highest sales?
	SELECT TOP 1 
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM 
    KMS
WHERE 
    Customer_Segment = 'Small Business'
GROUP BY 
    Customer_Name
ORDER BY 
    Total_Sales DESC;

	---8. Which Corporate Customer placed the most number of orders in 2009 – 2012?


	SELECT TOP 1 
    Customer_Name,
    COUNT(*) AS Number_of_Orders
FROM 
    KMS
WHERE 
    Customer_Segment = 'Corporate'
    AND YEAR(Order_Date) BETWEEN 2009 AND 2012
GROUP BY 
    Customer_Name
ORDER BY 
    Number_of_Orders DESC;

	------------9. Which consumer customer was the most profi table one?


	SELECT TOP 1 
    Customer_Name,
    SUM(Profit) AS Total_Profit
FROM 
    KMS
WHERE 
    Customer_Segment = 'Consumer'
GROUP BY 
    Customer_Name
ORDER BY 
    Total_Profit DESC;


	------10. Which customer returned items, and what segment do they belong to?
SELECT DISTINCT 
    K.Customer_Name, 
    K.Customer_Segment
FROM 
    KMS K
JOIN 
    Order_Status O
    ON K.Order_ID = O.Order_ID
WHERE 
    O.Status = 'Returned';


	-------- 11. If the delivery truck is the most economical but the slowest shipping method and Express Air is the fastest but the most expensive one, do you think the company appropriately spent shipping costs based on the Order Priority? Explain your answer
	------- Shipping Method by Order Priority
	SELECT 
    Ship_Mode,
    Order_Priority,
    COUNT(*) AS Number_of_Orders,
    AVG(Shipping_Cost) AS Avg_Shipping_Cost
FROM 
    KMS
GROUP BY 
    Ship_Mode, 
    Order_Priority
ORDER BY 
    Order_Priority, 
    Ship_Mode;
	/* 
	Shipping Cost Efficiency Analysis
	Our review of shipping practices in relation to order priority reveals a generally sound alignment between urgency and delivery method. Most high and critical priority orders were dispatched via Express Air, prioritizing speed even at a higher cost. In contrast, low priority orders predominantly used Delivery Truck—the most cost-effective option available.
	Overall, the shipping approach reflects thoughtful cost management. However, we did identify a few outliers where low priority items were sent using Express Air and some high priority orders went out by truck. These inconsistencies highlight areas where policy enforcement could be improved.
	To enhance cost control while maintaining appropriate delivery times, we recommend adopting clearer shipping guidelines that consistently align transport method with order urgency.
	*/
