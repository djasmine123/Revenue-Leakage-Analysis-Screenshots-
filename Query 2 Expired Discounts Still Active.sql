USE Revenue_Leakage_Analysis;

-- Query 2: Expired Discounts Still Active
SELECT 
    d.DiscountID,
    d.CustomerID,
    c.CustomerName,
    d.DiscountCode,
    d.DiscountPercent,
    d.EndDate AS DiscountEndDate,
    d.[Status],
    DATEDIFF(DAY, d.EndDate, GETDATE()) AS DaysExpired,
    'Expired Discount Active' AS LeakageType
FROM Discounts_Applied d
INNER JOIN Customers c ON d.CustomerID = c.CustomerID
WHERE d.[Status] = 'Active'
    AND d.EndDate < GETDATE()
ORDER BY DaysExpired DESC;