-- =============================================
-- Author:		<Author,,Name>
-- Create date: <06th NOV 2020>
-- Update date: <>
-- Description:	<Description,,>
-- =============================================
--EXEC SPR_Get_TailoringConfig
CREATE PROCEDURE SPR_Get_TailoringConfig

AS
BEGIN

	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''

	SELECT [ConfigID],[ConfigName],[ConfigValue]
	FROM [dbo].[tblTailoringConfig] WITH(NOLOCK)

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