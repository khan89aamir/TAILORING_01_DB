-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <12th OCT 2020>
-- Update date: <07th FEB 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Search_Product]
CREATE PROCEDURE [dbo].[SPR_Search_Product]
@GarmentName NVARCHAR(MAX)='0'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=@GarmentName
	DECLARE @IMGPATH VARCHAR(MAX)=''

	SET @IMGPATH=(SELECT [ConfigValue]
	FROM [dbo].[tblTailoringConfig] WITH(NOLOCK) WHERE [ConfigName]='GenericImagePath')

	SELECT GarmentID,GarmentName
	,GarmentType, IIF(Photo IS NULL,Photo,CONCAT(@IMGPATH,Photo)) Photo
	,CONVERT(INT,LastChange) LastChange
	FROM dbo.tblProductMaster WITH(NOLOCK)
	WHERE GarmentName LIKE IIF(@GarmentName='0',GarmentName,'%'+@GarmentName+'%')

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