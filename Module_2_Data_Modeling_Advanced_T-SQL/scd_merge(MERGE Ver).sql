--Giả sử đã có bảng Dim_Customer và một bảng Staging_Customer (chứa dữ liệu mới vừa đổ vào).
-- Dùng merge để thực hiện logic SCD Type 2 : Tìm row trong Staging khác Dim, Expire old row in Dim, Insert new row in Dim

--Psuedo code logic :

--Dim_Customer is target table and Staging is source?
-- Chỉ insert những thằng mới hoặc thằng vừa bị Expire ở trên


MERGE INTO Dim_Customer AS T
USING Staging_Customer AS S
    ON T.Customer_Source_ID = S.Customer_Source_ID AND T.Is_Current = 1
WHEN MATCHED AND (T.Customer_Name <> S.Customer_Name
                   OR T.City <> S.City
                   OR T.Phone <> S.Phone) THEN
    UPDATE SET T.Is_Current = 0, T.Valid_To = GETDATE()
WHEN NOT MATCHED BY TARGET THEN
    -- Action for rows in the source that do not exist in the target (e.g., INSERT)
    INSERT (Customer_Source_ID, Customer_Name, City, Phone, Valid_From, Valid_To, Is_Current) VALUES (S.Customer_Source_ID, S.Customer_Name, S.City, S.Phone, GETDATE(), '9999-12-31', 1);


--Phase 2 insert with info from staging
INSERT INTO Dim_Customer(Customer_Source_ID, Customer_Name, City, Phone, Valid_From, Valid_To, Is_Current)
SELECT S.Customer_Source_ID, S.Customer_Name, S.City, S.Phone, GETDATE(), '9999-12-31', 1 --Insert dữ liệu và set metadata từ stage
FROM Staging_Customer S
INNER JOIN Dim_Customer T
    ON S.Customer_Source_ID = T.Customer_Source_ID
    AND T.Is_Current = 0
    AND CAST(T.Valid_To AS DATE) = CAST(GETDATE() AS DATE) --Dòng này để sửa hàm getdate, chỉ so sánh ngày, tránh trường hợp lệch milisecond làm lỗi

