-- =============================================
-- Author:		<AAMIR>
-- Create date: <12th MAR 2021>
-- Update date: <>
-- Description:	<Description,,>
-- =============================================
--EXEC SPR_Get_MobileActivation
CREATE PROCEDURE SPR_Get_MobileActivation

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''

	  SELECT [Id]
      ,[SerialNumber]
      ,[ActivationCode]
      ,[CreatedOn] 
	  FROM tblMobileActivation WITH(NOLOCK)
	  ORDER BY [CreatedOn] DESC

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