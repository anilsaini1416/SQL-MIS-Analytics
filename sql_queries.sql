-- =========================================================================
-- PROJECT: E-Commerce & Retail MIS Dashboard Analytics
-- =========================================================================

use mis;

-- -------------------------------------------------------------------------
-- MODULE 1: EXECUTIVE SUMMARY & HIGH-LEVEL KPIs
-- -------------------------------------------------------------------------
SELECT 
    COUNT(DISTINCT o.`Order ID`) AS Total_Orders,
    SUM(d.Quantity) AS Total_Items_Sold,
    ROUND(SUM(d.Amount), 2) AS Total_Revenue,
    ROUND(SUM(d.Profit), 2) AS Total_Profit,
    ROUND((SUM(d.Profit) / SUM(d.Amount)) * 100, 2) AS Profit_Margin_Percentage
FROM `list of orders` o
JOIN `order details` d ON o.`Order ID` = d.`Order ID`;


-- -------------------------------------------------------------------------
-- MODULE 2: REGIONAL & GEOGRAPHIC PERFORMANCE (STATE LEVEL)
-- -------------------------------------------------------------------------

-- 2.1 Top 5 States by Total Revenue and Profit
SELECT 
    o.State,
    ROUND(SUM(d.Amount), 2) AS Total_Revenue,
    ROUND(SUM(d.Profit), 2) AS Total_Profit,
    SUM(d.Quantity) AS Total_Quantity
FROM `list of orders` o
JOIN `order details` d ON o.`Order ID` = d.`Order ID`
GROUP BY o.State
ORDER BY Total_Revenue DESC
LIMIT 5;

-- 2.2 Loss-Making States (Negative Profit Analysis)
SELECT 
    o.State,
    ROUND(SUM(d.Amount), 2) AS Total_Revenue,
    ROUND(SUM(d.Profit), 2) AS Total_Net_Loss
FROM `list of orders` o
JOIN `order details` d ON o.`Order ID` = d.`Order ID`
GROUP BY o.State
HAVING SUM(d.Profit) < 0
ORDER BY Total_Net_Loss ASC;


-- -------------------------------------------------------------------------
-- MODULE 3: PRODUCT & CATEGORY PERFORMANCE DEEP DIVE
-- -------------------------------------------------------------------------

-- 3.1 Category-wise Performance Summary
SELECT 
    d.Category,
    ROUND(SUM(d.Amount), 2) AS Total_Revenue,
    ROUND(SUM(d.Profit), 2) AS Total_Profit,
    ROUND((SUM(d.Profit) / SUM(d.Amount)) * 100, 2) AS Margin_Percent
FROM `order details` d
GROUP BY d.Category
ORDER BY Total_Revenue DESC;

-- 3.2 Sub-Category Profitability Breakdown
SELECT 
    d.Category,
    d.`Sub-Category`,
    SUM(d.Quantity) AS Units_Sold,
    ROUND(SUM(d.Amount), 2) AS Total_Revenue,
    ROUND(SUM(d.Profit), 2) AS Total_Profit
FROM `order details` d
GROUP BY d.Category, d.`Sub-Category`
ORDER BY Total_Profit DESC;


-- -------------------------------------------------------------------------
-- MODULE 4: CUSTOMER VALUE & SEGMENTATION ANALYSIS
-- -------------------------------------------------------------------------

-- Top 10 Customers by Total Spending (Lifetime Value)
SELECT 
    o.CustomerName,
    COUNT(DISTINCT o.`Order ID`) AS Total_Orders_Placed,
    ROUND(SUM(d.Amount), 2) AS Total_Spent,
    ROUND(SUM(d.Profit), 2) AS Total_Profit_Generated
FROM `list of orders` o
JOIN `order details` d ON o.`Order ID` = d.`Order ID`
GROUP BY o.CustomerName
ORDER BY Total_Spent DESC
LIMIT 10;


-- -------------------------------------------------------------------------
-- MODULE 5: ADVANCED SQL (CTEs & WINDOW FUNCTIONS FOR MIS)
-- -------------------------------------------------------------------------

-- 5.1 Monthly Revenue & Trend Analysis
SELECT 
    DATE_FORMAT(STR_TO_DATE(o.`Order Date`, '%d-%m-%Y'), '%Y-%m') AS Order_Month,
    ROUND(SUM(d.Amount), 2) AS Monthly_Revenue,
    ROUND(SUM(d.Profit), 2) AS Monthly_Profit,
    COUNT(DISTINCT o.`Order ID`) AS Monthly_Orders
FROM `list of orders` o
JOIN `order details` d ON o.`Order ID` = d.`Order ID`
GROUP BY Order_Month
ORDER BY Order_Month ASC;

-- 5.2 Ranking Sub-Categories within each Category using Window Functions
WITH SubCategoryPerformance AS (
    SELECT 
        Category,
        `Sub-Category`,
        SUM(Amount) AS Total_Revenue,
        SUM(Profit) AS Total_Profit
    FROM `order details`
    GROUP BY Category, `Sub-Category`
)
SELECT 
    Category,
    `Sub-Category`,
    ROUND(Total_Revenue, 2) AS Total_Revenue,
    ROUND(Total_Profit, 2) AS Total_Profit,
    DENSE_RANK() OVER(PARTITION BY Category ORDER BY Total_Profit DESC) AS Profit_Rank_In_Category
FROM SubCategoryPerformance;