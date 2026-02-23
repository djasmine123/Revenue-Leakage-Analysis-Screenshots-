USE Revenue_Leakage_Analysis;

-- Query 1: Billing vs Usage Mismatch
SELECT 
    b.BillingID,
    b.CustomerID,
    c.CustomerName,
    b.BillingMonth,
    b.UsageCharges AS BilledUsage,
    (u.RoamingCharges + u.ValueAddedServices) AS ActualUsage,
    (u.RoamingCharges + u.ValueAddedServices - b.UsageCharges) AS LeakageAmount,
    'Usage Not Billed' AS LeakageType
FROM Billing_Transactions b
INNER JOIN Service_Usage u 
    ON b.CustomerID = u.CustomerID 
    AND b.BillingMonth = u.[Month]
INNER JOIN Customers c 
    ON b.CustomerID = c.CustomerID
WHERE (u.RoamingCharges + u.ValueAddedServices) > b.UsageCharges
    AND (u.RoamingCharges + u.ValueAddedServices - b.UsageCharges) > 50
ORDER BY LeakageAmount DESC;