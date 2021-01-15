-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <08th DEC 2020>
-- Update date: <16th JAN 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Get_OrderList] 0,NULL,NULL
CREATE PROCEDURE [dbo].[SPR_Get_OrderList]
@CustomerID INT=0
,@FromDate DATE
,@ToDate DATE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@CustomerID,',',@FromDate,',',@ToDate)


	SELECT cm.CustomerID,cm.Name,so.SalesOrderID,so.OrderNo,so.OrderDate,so.OrderQTY,so.TotalAmount
	,so.OrderAmount [To be Paid],so.OrderMode,ed.Name [CreatedBy]
	FROM [dbo].[tblSalesOrder] so
	INNER JOIN dbo.CustomerMaster cm ON so.CustomerID=cm.CustomerID
	LEFT JOIN dbo.EmployeeDetails ed ON so.CreatedBy=ed.EmpID
	WHERE cm.CustomerID=IIF(@CustomerID=0,cm.CustomerID,@CustomerID)
	AND so.OrderDate BETWEEN ISNULL(@FromDate,so.OrderDate) AND ISNULL(@ToDate,so.OrderDate)
	ORDER BY so.SalesOrderID DESC,so.OrderDate DESC

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