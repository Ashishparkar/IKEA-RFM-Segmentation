--DEDUPLICATE AND PRODUCE THE FINAL CLEANED TABLE--
WITH Deduped AS (
	SELECT *,
		ROW_NUMBER() OVER(
			PARTITION BY Invoice, StockCode, Description, Quantity, InvoiceDate, Price, Customer_ID, Country
			ORDER BY (SELECT NULL)
		) AS RowNum
	FROM dbo.RetailCombined
)
SELECT Invoice, StockCode, Description, Quantity, InvoiceDate, Price, Customer_ID, Country,
INTO dbo.RetailCleaned
FROM Deduped
WHERE RowNum = 1;

SELECT * FROM dbo.RetailCombined;