-- Kiểm tra xem index đã tồn tại chưa trước khi tạo
IF NOT EXISTS (
    SELECT *
    FROM sys.indexes
    WHERE name = 'IX_Customer_Key'
    AND object_id = OBJECT_ID('[dbo].[Fact_Sales]')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Customer_Key
    ON [dbo].[Fact_Sales](Customer_Key)

    PRINT 'Index IX_Customer_Key đã được tạo thành công!'
END
ELSE
BEGIN
    PRINT 'Index IX_Customer_Key đã tồn tại, bỏ qua việc tạo mới.'
END