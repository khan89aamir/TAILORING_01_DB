﻿-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <15th NOV 2020>
-- Update date: <>
-- Description:	<Description,,>
-- =============================================
--EXEC SPR_Insert_SalesOrderDetails 0,0,0,0,0,0
CREATE PROCEDURE [dbo].[SPR_Insert_SalesOrderDetails]
--@SalesOrderID	INT=0
--,@GarmentID		INT=0
--,@TrimAmount	DECIMAL(18,2)=0	
--,@QTY			INT=0
--,@Rate			DECIMAL(18,2)=0
--,@Total			DECIMAL(18,2)=0
--,@CreatedBy		INT=0
@dtSalesOrderDetails dbo.tblSalesOrderDetailsType READONLY
,@dtMeasurement dbo.tblCustomerMeasurementType READONLY
,@dtStyle dbo.tblCustomerStyleType READONLY
,@dtBodyPosture dbo.tblCustomerBodyPostureType READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	--SET @PARAMERES=CONCAT(@SalesOrderID,',',@GarmentID,',',@TrimAmount,',',@QTY,',',@Rate,',',@Total,',',@CreatedBy)
	BEGIN TRANSACTION

	INSERT tblSalesOrderDetails
	(
	SalesOrderID
	,GarmentID
	,TrimAmount
	,QTY
	,Rate
	,Total
	,CreatedBy
	)
	SELECT SalesOrderID
	,GarmentID
	,TrimAmount
	,QTY
	,Rate
	,Total
	,CreatedBy
	FROM @dtSalesOrderDetails
	--VALUES(@SalesOrderID,@GarmentID,@TrimAmount,@QTY,@Rate,@Total,@CreatedBy)

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


	INSERT tblCustomerStyle
	(
	SalesOrderID
	,GarmentID
	,StyleID
	,StyleImageID
	,CreatedBy
	)

	SELECT 	SalesOrderID
	,GarmentID
	,StyleID
	,StyleImageID
	,CreatedBy
	FROM  @dtStyle


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