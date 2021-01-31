-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <31st JAN 2021>
-- Update date: <>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].SPR_Get_MasterOrderDetails 1
CREATE PROCEDURE [dbo].SPR_Get_MasterOrderDetails
@SalesOrderID INT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=@SalesOrderID


	SELECT so.SalesOrderID,sd.SalesOrderDetailsID,pm.GarmentName,pm.GarmentID,pm.GarmentCode
	, st.StichTypeName ,ft.FitTypeName ,sd.TrimAmount,sd.QTY,sd.Rate,
	(CASE sd.[Service] WHEN 1 THEN 'Urgent' WHEN 0 THEN 'Normal' END) [Service]
	,IIF(sd.TrailDate='1900-01-01',NULL,sd.TrailDate) TrailDate,sd.DeliveryDate,
	(sd.QTY*sd.Rate) as Total
	FROM [dbo].[tblSalesOrder] so
	INNER JOIN [dbo].[tblSalesOrderDetails] sd ON so.SalesOrderID=sd.SalesOrderID
	INNER JOIN dbo.tblProductMaster pm ON sd.GarmentID=pm.GarmentID
	INNER JOIN dbo.CustomerMaster cm ON so.CustomerID=cm.CustomerID
	INNER JOIN [dbo].[tblFitTypeMaster] ft ON sd.FitTypeID=ft.FitTypeID
	INNER JOIN [dbo].[tblStichTypeMaster] st ON sd.StichTypeID=st.StichTypeID
	LEFT JOIN dbo.EmployeeDetails ed ON so.CreatedBy=ed.EmpID
	WHERE so.SalesOrderID=@SalesOrderID AND sd.GarmentID=sd.MasterGarmentID
	
	UNION

	SELECT TOP 1 so.SalesOrderID,sd.SalesOrderDetailsID,pm.GarmentName,pm.GarmentID,pm.GarmentCode
	, st.StichTypeName ,ft.FitTypeName ,sd.TrimAmount,sd.QTY,sd.Rate,
	(CASE sd.[Service] WHEN 1 THEN 'Urgent' WHEN 0 THEN 'Normal' END) [Service]
	,IIF(sd.TrailDate='1900-01-01',NULL,sd.TrailDate) TrailDate,sd.DeliveryDate,
	(sd.QTY*sd.Rate) as Total
	FROM [dbo].[tblSalesOrder] so
	INNER JOIN [dbo].[tblSalesOrderDetails] sd ON so.SalesOrderID=sd.SalesOrderID
	INNER JOIN dbo.tblProductMaster pm ON sd.MasterGarmentID=pm.GarmentID
	INNER JOIN dbo.CustomerMaster cm ON so.CustomerID=cm.CustomerID
	INNER JOIN [dbo].[tblFitTypeMaster] ft ON sd.FitTypeID=ft.FitTypeID
	INNER JOIN [dbo].[tblStichTypeMaster] st ON sd.StichTypeID=st.StichTypeID
	LEFT JOIN dbo.EmployeeDetails ed ON so.CreatedBy=ed.EmpID
	WHERE so.SalesOrderID=@SalesOrderID AND sd.GarmentID<>sd.MasterGarmentID


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