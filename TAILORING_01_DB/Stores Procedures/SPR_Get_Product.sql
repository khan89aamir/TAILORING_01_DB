-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <12th OCT 2020>
-- Update date: <22nd FEB 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Get_Product] 1
CREATE PROCEDURE [dbo].[SPR_Get_Product]
@GarmentID INT=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=@GarmentID

	DECLARE @ImagePath VARCHAR(MAX)=''

	SET @ImagePath=(SELECT TOP 1 GenericImagePath FROM tblSoftwareSetting WITH(NOLOCK))
	SET @ImagePath=CONCAT(@ImagePath,'\')

	SELECT GarmentID,GarmentName
	,GarmentType, IIF(Photo IS NULL,Photo,CONCAT(@ImagePath,Photo)) Photo
	,CONVERT(INT,LastChange) LastChange
	FROM dbo.tblProductMaster WITH(NOLOCK)
	WHERE GarmentID=IIF(@GarmentID=0,GarmentID,@GarmentID)

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