﻿-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <03rd JAN 2021>
-- Update date: <07th MAR 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC SPR_Get_GarmentMeasurementStyle 1
CREATE PROCEDURE [dbo].[SPR_Get_GarmentMeasurementStyle]
@OrderID INT=0

AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRY

	DECLARE @ImagePath VARCHAR(MAX)=''
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=@OrderID

	SET @ImagePath=(SELECT TOP 1 GenericImagePath FROM tblSoftwareSetting WITH(NOLOCK))
	SET @ImagePath=CONCAT(@ImagePath,'\')

	--Garment Details
	SELECT a.MasterGarmentID,a.GarmentID,a.GarmentName,a.StichTypeID,a.FitTypeID,a.QTY,a.Photo,a.OrderStatus FROM
	(
		SELECT sd.MasterGarmentID,pm.GarmentID,pm.GarmentName,st.StichTypeID
		,ft.FitTypeID,t.QTY,CONCAT(@ImagePath,pm.Photo) Photo
		,os.OrderStatus,sd.SalesOrderDetailsID
		,ROW_NUMBER() OVER(PARTITION BY sd.MasterGarmentID,pm.GarmentID ORDER BY pm.GarmentID) rw
		FROM [dbo].[tblSalesOrder] so
		INNER JOIN [dbo].[tblSalesOrderDetails] sd ON so.SalesOrderID=sd.SalesOrderID
		INNER JOIN 
		(
			SELECT SalesOrderID,MasterGarmentID,GarmentID,SUM(QTY) QTY 
			FROM [tblSalesOrderDetails] WITH(NOLOCK) WHERE SalesOrderID=@OrderID
			GROUP BY SalesOrderID,MasterGarmentID,GarmentID
		)t ON sd.SalesOrderID=t.SalesOrderID AND sd.GarmentID=t.GarmentID
		INNER JOIN dbo.tblProductMaster pm ON sd.GarmentID=pm.GarmentID
		INNER JOIN dbo.CustomerMaster cm ON so.CustomerID=cm.CustomerID
		INNER JOIN [dbo].[tblFitTypeMaster] ft ON sd.FitTypeID=ft.FitTypeID
		INNER JOIN [dbo].[tblStichTypeMaster] st ON sd.StichTypeID=st.StichTypeID
		INNER JOIN dbo.tblOrderStatus os ON sd.SalesOrderDetailsID=os.SalesOrderDetailsID AND os.SalesOrderID=@OrderID
		WHERE so.SalesOrderID=@OrderID
	)a
	WHERE a.rw=1
	ORDER BY a.GarmentName
	--a.SalesOrderDetailsID

	--SELECT pm.GarmentID,pm.GarmentName,st.StichTypeID,ft.FitTypeID
	--,SUM(sd.QTY) QTY,CONCAT(@ImagePath,pm.Photo) Photo
	--,os.OrderStatus
	----sd.TrailDate,sd.DeliveryDate
	--FROM [dbo].[tblSalesOrder] so
	--INNER JOIN [dbo].[tblSalesOrderDetails] sd ON so.SalesOrderID=sd.SalesOrderID
	--INNER JOIN dbo.tblProductMaster pm ON sd.GarmentID=pm.GarmentID
	--INNER JOIN dbo.CustomerMaster cm ON so.CustomerID=cm.CustomerID
	--INNER JOIN [dbo].[tblFitTypeMaster] ft ON sd.FitTypeID=ft.FitTypeID
	--INNER JOIN [dbo].[tblStichTypeMaster] st ON sd.StichTypeID=st.StichTypeID
	--INNER JOIN dbo.tblOrderStatus os ON sd.SalesOrderDetailsID=os.SalesOrderDetailsID AND os.SalesOrderID=@OrderID
	--WHERE so.SalesOrderID=@OrderID
	--GROUP BY pm.GarmentID,pm.GarmentName,st.StichTypeID
	--,ft.FitTypeID,Photo,sd.SalesOrderDetailsID,os.OrderStatus
	--ORDER BY sd.SalesOrderDetailsID

	--Measurement details
	SELECT  cm.MasterGarmentID,cm.GarmentID,cm.MeasurementID
	,IIF(CONVERT(VARCHAR,cm.MeasurementValue)='0.00','',CONVERT(VARCHAR,cm.MeasurementValue)) MeasurementValue
	FROM [dbo].tblCustomerMeasurement cm
	INNER JOIN [dbo].[tblMeasurementMaster] mm ON cm.MeasurementID=mm.MeasurementID
	WHERE cm.SalesOrderID=@OrderID
	ORDER BY cm.GarmentID,cm.MeasurementID

	--Style Name AND Image
	SELECT  cs.CustStyleID,cs.MasterGarmentID,cs.GarmentID,cs.StyleID,cs.QTY,cs.StyleImageID
	FROM [dbo].tblCustomerStyle cs
	INNER JOIN [dbo].[tblStyleMaster] sm ON cs.StyleID=sm.StyleID
	WHERE cs.SalesOrderID=@OrderID
	ORDER BY cs.GarmentID,cs.QTY,cs.StyleID

	--Body Posture Image
	SELECT cb.BodyPostureMappingID,cb.BodyPostureID,cb.MasterGarmentID,cb.GarmentID
	FROM [dbo].[tblCustomerBodyPosture] cb
	INNER JOIN [dbo].[tblBodyPostureMaster] bp ON cb.BodyPostureID=bp.BodyPostureID
	WHERE cb.SalesOrderID=@OrderID
	ORDER BY cb.BodyPostureID,cb.BodyPostureMappingID


	SELECT sd.MasterGarmentID,pm.GarmentID,pm.GarmentName,st.StichTypeID
		,ft.FitTypeID,sd.QTY,pm.Photo
		,os.OrderStatus,sd.SalesOrderDetailsID
		,ROW_NUMBER() OVER(PARTITION BY pm.GarmentID ORDER BY pm.GarmentID) rw
		FROM [dbo].[tblSalesOrder] so
		INNER JOIN [dbo].[tblSalesOrderDetails] sd ON so.SalesOrderID=sd.SalesOrderID
		INNER JOIN dbo.tblProductMaster pm ON sd.GarmentID=pm.GarmentID
		INNER JOIN dbo.CustomerMaster cm ON so.CustomerID=cm.CustomerID
		INNER JOIN [dbo].[tblFitTypeMaster] ft ON sd.FitTypeID=ft.FitTypeID
		INNER JOIN [dbo].[tblStichTypeMaster] st ON sd.StichTypeID=st.StichTypeID
		INNER JOIN dbo.tblOrderStatus os ON sd.SalesOrderDetailsID=os.SalesOrderDetailsID AND os.SalesOrderID=@OrderID
		WHERE so.SalesOrderID=@OrderID

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