-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <25th JAN 2021>
-- Update date: <06th MAR 2021>
-- Description:	<Description,,>
-- =============================================
-- DROP PROCEDURE [dbo].[SPR_Update_SalesOrderDetails]
--EXEC SPR_Update_SalesOrderDetails 0,0,0,0
CREATE PROCEDURE [dbo].[SPR_Update_SalesOrderDetails]
@dtSalesOrderDetails dbo.tblSalesOrderDetailsUpdateType READONLY
,@dtMeasurement dbo.tblCustomerMeasurementType READONLY
,@dtStyle dbo.tblCustomerStyleType READONLY
,@dtBodyPosture dbo.tblCustomerBodyPostureType READONLY
,@SalesOrderID	INT=0
,@Flag INT=0 OUTPUT

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
	INNER JOIN @dtSalesOrderDetails sd ON so.SalesOrderID=sd.SalesOrderID 
	AND so.SalesOrderDetailsID=sd.SalesOrderDetailsID AND so.GarmentID=sd.GarmentID

	DELETE FROM tblCustomerMeasurement WHERE SalesOrderID=@SalesOrderID
	INSERT tblCustomerMeasurement
	(
	SalesOrderID
	,MasterGarmentID
	,GarmentID
	,MeasurementID
	,MeasurementValue
	,CreatedBy
	)
	SELECT 
	SalesOrderID
	,MasterGarmentID
	,GarmentID
	,MeasurementID
	,MeasurementValue
	,CreatedBy
	FROM @dtMeasurement


	DELETE FROM tblCustomerStyle WHERE SalesOrderID=@SalesOrderID
	INSERT tblCustomerStyle
	(
	SalesOrderID
	,MasterGarmentID
	,GarmentID
	,StyleID
	,QTY
	,StyleImageID
	,CreatedBy
	)

	SELECT 	SalesOrderID
	,MasterGarmentID
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
	,MasterGarmentID
	,GarmentID
	,BodyPostureID
	,BodyPostureMappingID
	,CreatedBy
	)

	SELECT 	SalesOrderID
	,MasterGarmentID
	,GarmentID
	,BodyPostureID
	,BodyPostureMappingID
	,CreatedBy
	FROM  @dtBodyPosture
	
	SET @Flag=1
	COMMIT

	END TRY

	BEGIN CATCH
	SET @Flag=0
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