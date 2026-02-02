--Question 1: Category Performance
-- Mẫu chuẩn (Học thuộc cú pháp này):
SELECT TOP 1
    P.Category,
    SUM(S.Total_Amount) AS Total_Revenue -- Phải dùng SUM
FROM Fact_Sales S
JOIN Dim_Product P ON S.Product_Key = P.Product_Key -- JOIN qua Key là chuẩn 100%
GROUP BY P.Category -- Gom nhóm lại
ORDER BY Total_Revenue DESC;


--Question 2: VIP Customers --> top 5 khách chịu chi nhất, output name, city, total spent
SELECT TOP 5
    D.Customer_Name, D.City,
    SUM(S.Total_Amount) AS Total_Amount
FROM Dim_Customer D
JOIN Fact_Sales S ON D.Customer_Key = S.Customer_Key
GROUP BY D.Customer_Name, D.City --khi select mà k có tính toán như sum thì nên group by nó
ORDER BY Total_Amount DESC;


--Question 3: Monthly Trend (Test độ cứng của Dim_Date)
SELECT
    D.Month, D.Year,
    SUM(S.Total_Amount) AS Total_Amount
FROM Dim_Date D
JOIN Fact_Sales S ON D.Date_Key = S.Date_Key
GROUP BY D.Year, D.Month
ORDER BY D.Year, D.Month