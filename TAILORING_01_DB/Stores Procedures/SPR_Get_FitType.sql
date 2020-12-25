-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <5th NOV 2020>
-- UPDATE date: <25th DEC 2020>
-- Description:	<Description,,>
-- =============================================
--EXEC SPR_Get_FitType
CREATE PROCEDURE [dbo].[SPR_Get_FitType]

AS
BEGIN
	
	SET NOCOUNT ON;
	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	
	SELECT FitTypeID,FitTypeName,CONVERT(INT,LastChange) LastChange FROM 
	[dbo].[tblFitTypeMaster] WITH(NOLOCK)

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