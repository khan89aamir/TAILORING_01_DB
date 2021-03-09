-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <09th MAR 2021>
-- Update date: <>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].SPR_Get_Invoice_Calculation 1
CREATE PROCEDURE [dbo].[SPR_Get_Invoice_Calculation]
@OrderID INT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=@OrderID

	SELECT OrderAmount,( SELECT SUM(a.TrimAmount) FROM
	(
	SELECT sd.MasterGarmentID,sd.GarmentID,sd.TrimAmount, ROW_NUMBER() OVER(PARTITION BY sd.GarmentID,sd.[Service] ORDER BY				sd.GarmentID,sd.[Service]) rw
	FROM [dbo].[tblSalesOrderDetails] sd WITH(NOLOCK)
	WHERE sd.SalesOrderID=@OrderID
	)a
	WHERE a.rw=1) as TrimAmount, (CGST+SGST) as Tax,t1.TotalAmount 
	FROM [dbo].[tblSalesOrder] t1 WITH(NOLOCK) 
	WHERE t1.SalesOrderID=@OrderID

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