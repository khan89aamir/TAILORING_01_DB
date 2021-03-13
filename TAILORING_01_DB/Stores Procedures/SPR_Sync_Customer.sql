-- =============================================
-- Author:		<AAMIR>
-- Create date: <11th MAR 2021>
-- Update date: <13th MAR 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC SPR_Sync_Customer 2021
CREATE PROCEDURE [dbo].[SPR_Sync_Customer]
@LastChange INT=0

AS
BEGIN

	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=@LastChange

	SELECT CustomerID,[Name],[Address],MobileNo,EmailID,CONVERT(INT,LastChange) LastChange
	FROM CustomerMaster WITH(NOLOCK)
	WHERE CONVERT(INT,LastChange)>@LastChange

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