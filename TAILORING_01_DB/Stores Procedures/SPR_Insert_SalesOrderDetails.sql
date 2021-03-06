﻿-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <15th Nov 2020>
-- Update date: <06th MAR 2021>
-- Description:	<Description,,>
-- =============================================
-- DROP PROCEDURE [dbo].[SPR_Insert_SalesOrderDetails]
--EXEC SPR_Insert_SalesOrderDetails 0,0,0,0,0
CREATE PROCEDURE [dbo].[SPR_Insert_SalesOrderDetails]
@dtSalesOrderDetails dbo.tblSalesOrderDetailsType READONLY
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

	INSERT tblSalesOrderDetails
	(
	SalesOrderID
	,StichTypeID
	,FitTypeID
	,MasterGarmentID
	,GarmentID
	,TrimAmount
	,[Service]
	,TrailDate
	,DeliveryDate
	,QTY
	,Rate
	,Total
	,CreatedBy
	)
	SELECT SalesOrderID
	,StichTypeID
	,FitTypeID
	,MasterGarmentID
	,GarmentID
	,TrimAmount
	,[Service]
	,Convert(Date,TrailDate)
	,Convert(Date,DeliveryDate)
	,QTY
	,Rate
	,Total
	,CreatedBy
	FROM @dtSalesOrderDetails


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
	

	INSERT tblOrderStatus
	(
	SalesOrderID
	,SalesOrderDetailsID
	,OrderStatus
	)
	SELECT SalesOrderID
	,SalesOrderDetailsID
	,3
	FROM tblSalesOrderDetails WITH(NOLOCK) 
	WHERE SalesOrderID=@SalesOrderID

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