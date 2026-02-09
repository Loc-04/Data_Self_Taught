CREATE OR ALTER PROCEDURE pr_GetMonthlyRevenue
    @ReportYear INT
AS
BEGIN
    SET NOCOUNT ON; -- Luôn có dòng này để tối ưu network traffic

    -- 1. Check if data exists
    IF NOT EXISTS (SELECT 1 FROM Dim_Date WHERE Year = @ReportYear)
    BEGIN
        PRINT 'No data found for year ' + CAST(@ReportYear AS VARCHAR);
        RETURN;
    END

    -- 2. Execute Query
    SELECT
    D.Month, D.Year,
    SUM(S.Total_Amount) AS Total_Amount
    FROM Dim_Date D
    JOIN Fact_Sales S ON D.Date_Key = S.Date_Key
    WHERE D.Year = @ReportYear
    GROUP BY D.Year, D.Month
    ORDER BY D.Year, D.Month
END