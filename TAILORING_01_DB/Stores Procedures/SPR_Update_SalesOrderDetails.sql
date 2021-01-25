-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <25th JAN 2021>
-- Update date: <26th JAN 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC SPR_Update_SalesOrderDetails 0,0,0,0
CREATE PROCEDURE [dbo].[SPR_Update_SalesOrderDetails]
@dtSalesOrderDetails dbo.tblSalesOrderDetailsType READONLY
,@dtMeasurement dbo.tblCustomerMeasurementType READONLY
,@dtStyle dbo.tblCustomerStyleType READONLY
,@dtBodyPosture dbo.tblCustomerBodyPostureType READONLY
,@SalesOrderID	INT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=@SalesOrderID
	BEGIN TRANSACTION
	
	UPDATE so
	SET so.StichTypeID=sd.StichTypeID,so.FitTypeID=sd.FitTypeID
	,so.UpdatedOn=GETDATE(),so.UpdatedBy=sd.CreatedBy
	FROM [dbo].[tblSalesOrderDetails] so
	INNER JOIN @dtSalesOrderDetails sd ON so.SalesOrderID=sd.SalesOrderID AND so.GarmentID=sd.GarmentID

	DELETE FROM tblCustomerMeasurement WHERE SalesOrderID=@SalesOrderID
	INSERT tblCustomerMeasurement
	(
	SalesOrderID
	,GarmentID
	,MeasurementID
	,MeasurementValue
	,CreatedBy
	)
	SELECT 
	SalesOrderID
	,GarmentID
	,MeasurementID
	,MeasurementValue
	,CreatedBy
	FROM @dtMeasurement


	DELETE FROM tblCustomerStyle WHERE SalesOrderID=@SalesOrderID
	INSERT tblCustomerStyle
	(
	SalesOrderID
	,GarmentID
	,StyleID
	,QTY
	,StyleImageID
	,CreatedBy
	)

	SELECT 	SalesOrderID
	,GarmentID
	,StyleID
	,QTY
	,StyleImageID
	,CreatedBy
	FROM  @dtStyle


	DELETE FROM tblCustomerBodyPosture WHERE SalesOrderID=@SalesOrderID
	INSERT tblCustomerBodyPosture
	(
	SalesOrderID
	,GarmentID
	,BodyPostureID
	,BodyPostureMappingID
	,CreatedBy
	)

	SELECT 	SalesOrderID
	,GarmentID
	,BodyPostureID
	,BodyPostureMappingID
	,CreatedBy
	FROM  @dtBodyPosture
	

	COMMIT

	END TRY

	BEGIN CATCH
	
	ROLLBACK

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