USE Revenue_Leakage_Analysis;

-- Query 5: Complete Leakage Summary
-- This combines all 4 leakage types into one view

-- Create a comprehensive summary
SELECT 
    'Billing vs Usage Mismatch' AS LeakageCategory,
    COUNT(DISTINCT b.CustomerID) AS CustomersAffected,
    COUNT(*) AS TotalCases,
    SUM(u.RoamingCharges + u.ValueAddedServices - b.UsageCharges) AS TotalLeakageAmount
FROM Billing_Transactions b
INNER JOIN Service_Usage u 
    ON b.CustomerID = u.CustomerID AND b.BillingMonth = u.[Month]
WHERE (u.RoamingCharges + u.ValueAddedServices) > b.UsageCharges
    AND (u.RoamingCharges + u.ValueAddedServices - b.UsageCharges) > 50

UNION ALL

SELECT 
    'Expired Discounts Active' AS LeakageCategory,
    COUNT(DISTINCT CustomerID),
    COUNT(*),
    972992 AS EstimatedMonthlyImpact  -- From our earlier calculation
FROM Discounts_Applied
WHERE [Status] = 'Active' AND EndDate < GETDATE()

UNION ALL

SELECT 
    'Failed Payments Not Followed Up' AS LeakageCategory,
    COUNT(DISTINCT b.CustomerID),
    COUNT(*),
    SUM(b.TotalBilled)
FROM Billing_Transactions b
INNER JOIN Customers c ON b.CustomerID = c.CustomerID
WHERE b.PaymentStatus IN ('Failed', 'Pending')
    AND c.AccountStatus = 'Active'
    AND DATEDIFF(DAY, CAST(b.BillingMonth + '-01' AS DATE), GETDATE()) > 90

UNION ALL

SELECT 
    'Data Overage Not Billed' AS LeakageCategory,
    COUNT(DISTINCT u.CustomerID),
    COUNT(*),
    SUM((u.DataUsedGB - p.DataLimitGB) * p.OverageRatePerGB)
FROM Service_Usage u
INNER JOIN Customers c ON u.CustomerID = c.CustomerID
INNER JOIN Pricing_Rules p ON c.[Plan] = p.PlanName
WHERE u.DataUsedGB > p.DataLimitGB
    AND p.OverageRatePerGB > 0
    AND ((u.DataUsedGB - p.DataLimitGB) * p.OverageRatePerGB) > 10

ORDER BY TotalLeakageAmount DESC;
