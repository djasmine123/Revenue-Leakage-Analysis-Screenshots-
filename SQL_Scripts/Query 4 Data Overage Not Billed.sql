USE Revenue_Leakage_Analysis;

-- Query 4: Data Overage Not Billed
SELECT 
    u.UsageID,
    u.CustomerID,
    c.CustomerName,
    c.[Plan],
    p.DataLimitGB AS PlanDataLimit,
    u.DataUsedGB AS ActualDataUsed,
    (u.DataUsedGB - p.DataLimitGB) AS OverageGB,
    p.OverageRatePerGB,
    ((u.DataUsedGB - p.DataLimitGB) * p.OverageRatePerGB) AS OverageChargeNotBilled,
    u.[Month],
    'Data Overage Not Charged' AS LeakageType
FROM Service_Usage u
INNER JOIN Customers c ON u.CustomerID = c.CustomerID
INNER JOIN Pricing_Rules p ON c.[Plan] = p.PlanName
WHERE u.DataUsedGB > p.DataLimitGB  -- Exceeded limit
    AND p.OverageRatePerGB > 0  -- Plan has overage charges
    AND ((u.DataUsedGB - p.DataLimitGB) * p.OverageRatePerGB) > 10  -- Leakage > ₹10
ORDER BY OverageChargeNotBilled DESC;
