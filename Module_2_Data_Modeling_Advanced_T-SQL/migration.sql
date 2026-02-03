--Update bảng để handle việc customer đổi vị trí mà k phải ghi đè dữ liệu, đặt luôn dữ liệu mặc định cho cột
ALTER TABLE Dim_Customer
ADD Valid_From DATETIME NOT NULL DEFAULT '2023-01-01',
    Valid_To DATETIME NOT NULL DEFAULT '9999-12-31',
    Is_Current BIT NOT NULL DEFAULT 1;