-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <29th DEC 2020>
-- Update date: <03rd JAN 2021>
-- Description:	<Description,,>
-- =============================================
-- EXEC SPR_Get_MeasurementValue_Report 2,1,0
CREATE PROCEDURE [dbo].[SPR_Get_MeasurementValue_Report]
@SalesOrderID INT=0
,@GarmentID INT=0
,@Show INT=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	DECLARE @query1  AS NVARCHAR(MAX)=''
	DECLARE @query2  AS NVARCHAR(MAX)
	DECLARE @ColumnName  AS VARCHAR(MAX)=''

	DECLARE @MeasurementID  AS INT=0
	DECLARE @MeasurementName  AS NVARCHAR(MAX)
	DECLARE @MeasurementValue  AS NVARCHAR(MAX)

	SET @PARAMERES=CONCAT(@SalesOrderID,',',@GarmentID,',',@Show)

	DECLARE cursor_Measurement CURSOR
	FOR

	 SELECT  mm.MeasurementID,mm.MeasurementName,cm.MeasurementValue
	 FROM [dbo].tblCustomerMeasurement cm
	 INNER JOIN [dbo].[tblMeasurementMaster] mm ON cm.MeasurementID=mm.MeasurementID
	 WHERE cm.SalesOrderID=@SalesOrderID AND cm.GarmentID=@GarmentID 
	 AND cm.MeasurementValue<>@Show
	 ORDER BY mm.MeasurementID

	 OPEN cursor_Measurement;

FETCH NEXT FROM cursor_Measurement INTO @MeasurementID,@MeasurementName,@MeasurementValue

	WHILE @@FETCH_STATUS = 0
	    BEGIN

		SET @query1 += N'MAX(CASE '+CAST(@MeasurementID as VARCHAR)+' WHEN '+CAST(@MeasurementID as VARCHAR)+
		' THEN '+CAST(''''+@MeasurementValue+'''' as VARCHAR)+' END) '+QUOTENAME(@MeasurementName);
		SET @ColumnName+=''''+CAST(@MeasurementName as VARCHAR)+''''+' AS '+CAST(QUOTENAME(@MeasurementName) as VARCHAR)

	    FETCH NEXT FROM cursor_Measurement INTO @MeasurementID,@MeasurementName,@MeasurementValue;

			IF @@FETCH_STATUS = 0 
			BEGIN
				SET @query1 +=','
				SET @ColumnName+=','
			END

	    END;

CLOSE cursor_Measurement;
 
DEALLOCATE cursor_Measurement;

--PRINT @query1
SET @ColumnName=CONCAT('SELECT ',@ColumnName)
 --PRINT @ColumnName
SET @query2=@ColumnName+' UNION ALL SELECT '+@query1+'
 FROM [dbo].tblCustomerMeasurement cm
 INNER JOIN [dbo].[tblMeasurementMaster] mm ON cm.MeasurementID=mm.MeasurementID
 WHERE cm.SalesOrderID='+CAST(@SalesOrderID as VARCHAR)+'
 AND cm.GarmentID='+CAST(@GarmentID as VARCHAR)+'  AND cm.MeasurementValue<>0'

--PRINT @query2

 EXEC (@query2)

 END TRY

	BEGIN CATCH
	
	INSERT [dbo].[ERROR_Log]
	(
	ERR_NUMBER
	, ERR_SEVERITY
	, ERR_STATE
	, ERR_LINE
	, ERR_MESSAGE
	, ERR_PROCEDURE
	, PARAMERES
	)
	SELECT  
	ERROR_NUMBER() 
	,ERROR_SEVERITY() 
	,ERROR_STATE() 
	,ERROR_LINE()
	,ERROR_MESSAGE()
	,'SPR_Get_MeasurementValue_Report'
	,@PARAMERES
	
	END CATCH
END