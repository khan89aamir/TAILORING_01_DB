-- =============================================
-- Author:		<AAMIR>
-- Create date: <14th MAR 2021>
-- Update date: <16th MAR 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC SPR_Sync_UserManagement 0
CREATE PROCEDURE [dbo].[SPR_Sync_UserManagement]
@LastChange INT=0

AS
BEGIN

	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=@LastChange

	SELECT UserID,UserName,[Password],EmailID,EmployeeID
	,CONVERT(INT,LastChange) LastChange,ActiveStatus
	FROM UserManagement WITH(NOLOCK)
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