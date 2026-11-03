USE retail_marketing_portfolio;

-- QUERY 1: Which social media platform generates the most clicks?
SELECT p.PlatformType, COUNT(c.ClickID) AS TotalClicks
FROM Platform p
JOIN Advertisement a ON p.PlatformID = a.PlatformID
JOIN Click c ON a.AdID = c.AdID
GROUP BY p.PlatformType
ORDER BY TotalClicks DESC;

-- QUERY 2: Campaign revenue under an illustrative same-day attribution rule.
-- Each order is assigned to at most one click: same customer and date,
-- highest ClickID when there are ties. IDs do not establish true event order.
-- Orders without a same-day click remain unattributed. This is not causal ROI.
SELECT ca.CampaignID, ca.CampaignName, ca.Budget,
       COUNT(o.OrderID) AS AttributedOrders,
       COALESCE(SUM(o.TotalAmount), 0) AS AttributedRevenue,
       ROUND(100.0 * COALESCE(SUM(o.TotalAmount), 0)
             / NULLIF(ca.Budget, 0), 2) AS RevenueToBudgetPercent
FROM Campaign ca
LEFT JOIN Advertisement a ON ca.CampaignID = a.CampaignID
LEFT JOIN Click cl ON a.AdID = cl.AdID
LEFT JOIN `Order` o ON o.CustomerID = cl.CustomerID
 AND o.OrderDate = cl.ClickDate
 AND cl.ClickID = (
     SELECT MAX(c2.ClickID)
     FROM Click c2
     WHERE c2.CustomerID = o.CustomerID AND c2.ClickDate = o.OrderDate
 )
GROUP BY ca.CampaignID, ca.CampaignName, ca.Budget
ORDER BY AttributedRevenue DESC, ca.CampaignID;

-- QUERY 3: Clicks per advertisement, not click-through rate.
-- Impression counts are unavailable, so a true CTR cannot be calculated.
SELECT p.PlatformID, p.PlatformType,
       COUNT(DISTINCT a.AdID) AS TotalAds,
       COUNT(c.ClickID) AS TotalClicks,
       ROUND(1.0 * COUNT(c.ClickID) / NULLIF(COUNT(DISTINCT a.AdID), 0), 2)
           AS ClicksPerAd
FROM Platform p
LEFT JOIN Advertisement a ON p.PlatformID = a.PlatformID
LEFT JOIN Click c ON a.AdID = c.AdID
GROUP BY p.PlatformID, p.PlatformType
ORDER BY ClicksPerAd DESC, p.PlatformID;

-- QUERY 4: Which customers spend the most?
SELECT c.CustomerID, c.Name, c.Location,
COUNT(o.OrderID) AS TotalOrders,
SUM(o.TotalAmount) AS TotalSpent
FROM Customer c
JOIN `Order` o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name, c.Location
ORDER BY TotalSpent DESC
LIMIT 10;

-- QUERY 5: Which products sell the most?
-- CatalogueValue uses current product prices, not historical realised revenue.
SELECT p.ProductName, p.Price,
SUM(c.Quantity) AS TotalUnitsSold,
SUM(c.Quantity * p.Price) AS CatalogueValue
FROM Product p
JOIN Contain c ON p.ProductID = c.ProductID
GROUP BY p.ProductName, p.Price
ORDER BY TotalUnitsSold DESC;

-- QUERY 6: Which city generates the most revenue?
SELECT c.Location, COUNT(o.OrderID) AS TotalOrders,
SUM(o.TotalAmount) AS TotalRevenue
FROM Customer c
JOIN `Order` o ON c.CustomerID = o.CustomerID
GROUP BY c.Location
ORDER BY TotalRevenue DESC;

-- QUERY 7: Click and order counts by age group.
-- DISTINCT prevents multiplication when customers have multiple clicks and orders.
-- Counts describe activity, not click-to-purchase conversion attribution.
SELECT
    CASE
        WHEN c.Age IS NULL THEN 'Unknown'
        WHEN c.Age < 18 THEN 'Under 18'
        WHEN c.Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN c.Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN c.Age BETWEEN 36 AND 45 THEN '36-45'
        ELSE '46+'
    END AS AgeGroup,
    COUNT(DISTINCT cl.ClickID) AS TotalClicks,
    COUNT(DISTINCT o.OrderID) AS TotalOrders
FROM Customer c
LEFT JOIN Click cl ON c.CustomerID = cl.CustomerID
LEFT JOIN `Order` o ON c.CustomerID = o.CustomerID
GROUP BY AgeGroup
ORDER BY TotalClicks DESC, AgeGroup;
