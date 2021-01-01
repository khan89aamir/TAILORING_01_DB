-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <02nd JAN 2021>
-- Update date: <>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Update_GSTData] 0,0,0,0,0,0
CREATE PROCEDURE [dbo].[SPR_Update_GSTData]
@GSTID INT=0
,@CGST DECIMAL(18,2)=0
,@SGST DECIMAL(18,2)=0
,@IGST DECIMAL(18,2)=0
,@UpdatedBy INT=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@CGST,',',@SGST,',',@IGST,',',@UpdatedBy)
	BEGIN TRANSACTION

	UPDATE tblGSTMaster
	SET CGST=@CGST,SGST=@SGST,IGST=@IGST,CreatedBy=@UpdatedBy
	WHERE GSTID=@GSTID

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