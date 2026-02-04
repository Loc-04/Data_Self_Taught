-- BƯỚC 1: EXPIRE (Đánh dấu dòng cũ là hết hạn nếu có thay đổi)
UPDATE D
SET
    D.Is_Current = 0,
    D.Valid_To = GETDATE()
FROM Dim_Customer D
JOIN Staging_Customer S ON D.Customer_Source_ID = S.Customer_Source_ID
WHERE
    D.Is_Current = 1 -- Chỉ xét dòng đang active
    AND (
        D.Customer_Name <> S.Customer_Name
        OR D.City <> S.City
        OR D.Phone <> S.Phone
        -- Lưu ý: Nếu cột cho phép NULL thì phải dùng ISNULL(A,'') <> ISNULL(B,'')
    );

-- BƯỚC 2: INSERT NEW VERSION (Thêm dòng mới cho thằng vừa expire HOẶC thằng mới toanh)
INSERT INTO Dim_Customer (Customer_Source_ID, Customer_Name, City, Phone, Valid_From, Valid_To, Is_Current)
SELECT
    S.Customer_Source_ID,
    S.Customer_Name,
    S.City,
    S.Phone,
    GETDATE(),    -- Valid_From = Hôm nay
    '9999-12-31', -- Valid_To = Future
    1             -- Is_Current = True
FROM Staging_Customer S
WHERE NOT EXISTS (
    SELECT 1
    FROM Dim_Customer D
    WHERE D.Customer_Source_ID = S.Customer_Source_ID
    AND D.Is_Current = 1
);