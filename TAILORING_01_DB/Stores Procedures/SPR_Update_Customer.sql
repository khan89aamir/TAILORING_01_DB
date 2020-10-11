-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <10th OCT 2020>
-- Update date: <12th OCT 2020>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Update_Customer] 0,0,0,0,0,0
CREATE PROCEDURE [dbo].[SPR_Update_Customer]
@CustomerID INT=0
,@Name NVarChar(MAX)=0
,@Address NVarChar(MAX)=0
,@MobileNo VarChar(MAX)=0
,@EmailID VarChar(MAX)=0
,@UpdatedBy INT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@CustomerID,',',@Name,',',@Address,',',@MobileNo,',',@EmailID,',',@UpdatedBy)
	BEGIN TRANSACTION

	UPDATE CustomerMaster SET
	[Name]=@Name,[Address]=@Address,MobileNo=@MobileNo,EmailID=@EmailID
	,UpdatedBy=@UpdatedBy,UpdatedOn=GETDATE()
	WHERE CustomerID=@CustomerID

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