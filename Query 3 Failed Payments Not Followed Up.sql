USE Revenue_Leakage_Analysis;

-- Query 3: Failed Payments Not Followed Up
SELECT 
    b.BillingID,
    b.CustomerID,
    c.CustomerName,
    c.AccountStatus,
    b.BillingMonth,
    b.TotalBilled,
    b.PaymentStatus,
    DATEDIFF(DAY, CAST(b.BillingMonth + '-01' AS DATE), GETDATE()) AS DaysSinceBilling,
    'Unpaid Bill - Service Active' AS LeakageType
FROM Billing_Transactions b
INNER JOIN Customers c ON b.CustomerID = c.CustomerID
WHERE b.PaymentStatus IN ('Failed', 'Pending')
    AND c.AccountStatus = 'Active'  -- Service still active!
    AND DATEDIFF(DAY, CAST(b.BillingMonth + '-01' AS DATE), GETDATE()) > 90  -- Over 90 days old
ORDER BY DaysSinceBilling DESC;