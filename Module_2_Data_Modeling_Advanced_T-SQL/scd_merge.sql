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
    INSERT (T.Customer_Source_Id, T.Customer_Name, T.City, T.Phone, T.Valid_From, T.Valid_To, T.Is_Current) VALUES (S.Customer_Source_Id, S.Customer_Name, S.City, S.Phone, GETDATE(), '9999-12-31', 1);