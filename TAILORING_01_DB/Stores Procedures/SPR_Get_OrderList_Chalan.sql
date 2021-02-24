-- =============================================
-- Author:		<AAMIR>
-- Create date: <22nd FEB 2021>
-- Update date: <>
-- Description:	<Description,,>
-- =============================================
-- EXEC SPR_Get_OrderList_Chalan 'INV-1'
CREATE PROCEDURE SPR_Get_OrderList_Chalan
@OrderNo VARCHAR(MAX)='0'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=@OrderNo

	SELECT SalesOrderID, OrderNo,OrderDate,OrderAmount,OrderQTY,TotalAmount,'View Details' AS ViewDetails 
	FROM dbo.tblSalesOrder 
	WHERE 
	OrderNo=IIF(@OrderNo='0',OrderNo,@OrderNo)
	AND SalesOrderID IN 
	(SELECT SalesOrderID FROM dbo.tblOrderStatus WITH(NOLOCK) WHERE OrderStatus in (3, 2)) 
	ORDER BY salesorderID DESC

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
GO