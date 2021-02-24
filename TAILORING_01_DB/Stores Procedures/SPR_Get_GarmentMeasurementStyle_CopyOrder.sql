-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <27th JAN 2021>
-- Update date: <23rd FEB 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC SPR_Get_GarmentMeasurementStyle_CopyOrder 1,1
CREATE PROCEDURE [dbo].[SPR_Get_GarmentMeasurementStyle_CopyOrder]
@CustomerID INT=0
,@GarmentID INT=0

AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY

	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@CustomerID,',',@GarmentID)

	DECLARE @SalesOrderID INT=0
	DECLARE @StichTypeID INT=0
	DECLARE @FitTypeID INT=0
	DECLARE @OrderDate DATE=NULL
	
	DECLARE @MinimumOrderCopy INT=0
	DECLARE @CustomerOrder INT=0

	--Fetching Minimum month for last Order copy
	SELECT TOP 1 @MinimumOrderCopy=CopyOrderMonth FROM [dbo].[tblSoftwareSetting] WITH(NOLOCK)

	--Fetching Garment Details
	SELECT TOP 1 @SalesOrderID=so.SalesOrderID,@StichTypeID=st.StichTypeID
	,@FitTypeID=ft.FitTypeID,@OrderDate=CONVERT(DATE,so.OrderDate)
	FROM [dbo].[tblSalesOrder] so
	INNER JOIN [dbo].[tblSalesOrderDetails] sd ON so.SalesOrderID=sd.SalesOrderID
	INNER JOIN dbo.tblProductMaster pm ON sd.GarmentID=pm.GarmentID
	INNER JOIN dbo.CustomerMaster cm ON so.CustomerID=cm.CustomerID
	INNER JOIN [dbo].[tblFitTypeMaster] ft ON sd.FitTypeID=ft.FitTypeID
	INNER JOIN [dbo].[tblStichTypeMaster] st ON sd.StichTypeID=st.StichTypeID
	WHERE so.CustomerID=@CustomerID AND sd.GarmentID=@GarmentID
	ORDER BY so.SalesOrderID DESC
	
	-- Get last order difference date in month
	SELECT @CustomerOrder=( DATEDIFF(mm,@OrderDate,CONVERT(DATE,GETDATE())) )
	
	IF @CustomerOrder<=@MinimumOrderCopy
		BEGIN

		SELECT @GarmentID [GarmentID],@StichTypeID [StichTypeID],@FitTypeID [FitTypeID]
		,@SalesOrderID [SalesOrderID],@OrderDate [OrderDate]

		--Measurement details
		SELECT  cm.GarmentID,cm.MeasurementID
		,IIF(CONVERT(VARCHAR,cm.MeasurementValue)='0.00','',CONVERT(VARCHAR,cm.MeasurementValue)) MeasurementValue
		FROM [dbo].tblCustomerMeasurement cm
		INNER JOIN [dbo].[tblMeasurementMaster] mm ON cm.MeasurementID=mm.MeasurementID
		WHERE cm.SalesOrderID=@SalesOrderID AND cm.GarmentID=@GarmentID
		--ORDER BY cm.GarmentID,cm.MeasurementID

		--Style Name AND Image
		SELECT  cs.CustStyleID,cs.GarmentID,cs.StyleID,cs.QTY,cs.StyleImageID
		FROM [dbo].tblCustomerStyle cs
		INNER JOIN [dbo].[tblStyleMaster] sm ON cs.StyleID=sm.StyleID
		WHERE cs.SalesOrderID=@SalesOrderID AND cs.GarmentID=@GarmentID
		--ORDER BY cs.GarmentID,cs.QTY,cs.StyleID

		--Body Posture Image
		SELECT cb.BodyPostureMappingID,cb.BodyPostureID,cb.GarmentID
		FROM [dbo].[tblCustomerBodyPosture] cb
		INNER JOIN [dbo].[tblBodyPostureMaster] bp ON cb.BodyPostureID=bp.BodyPostureID
		WHERE cb.SalesOrderID=@SalesOrderID AND cb.GarmentID=@GarmentID
		--ORDER BY cb.BodyPostureID,cb.BodyPostureMappingID
		END

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
	,ERROR_PROCEDURE()
	,@PARAMERES
	
	END CATCH

END