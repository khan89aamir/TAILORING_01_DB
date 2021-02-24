-- =============================================
-- Author:		<AAMIR>
-- Create date: <06th NOV 2020>
-- Update date: <22nd FEB 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC SPR_Get_BodyPosture_ByGarmentID 1
CREATE PROCEDURE [dbo].[SPR_Get_BodyPosture_ByGarmentID]
@GarmentID INT=0

AS
BEGIN

	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	DECLARE @GarmentType VARCHAR(MAX)=''
	DECLARE @ImagePath VARCHAR(MAX)=''

	SET @PARAMERES=@GarmentID

	SET @ImagePath=(SELECT TOP 1 ImagePath FROM tblSoftwareSetting WITH(NOLOCK))
	SET @ImagePath=CONCAT(@ImagePath,'\')

	SET @GarmentType=(SELECT GarmentType
	FROM tblProductMaster WITH(NOLOCK) WHERE GarmentID=@GarmentID)

	SELECT bm.BodyPostureID,bm.BodyPostureType
	FROM tblBodyPostureMaster bm WITH(NOLOCK)
	WHERE bm.GarmentType=@GarmentType

	SELECT bma.BodyPostureMappingID,bm.BodyPostureID,bm.BodyPostureType,bma.BodyPostureName
	,IIF(bma.BodyPostureImage IS NULL,bma.BodyPostureImage,CONCAT(@ImagePath,bma.BodyPostureImage)) Photo
	FROM tblBodyPostureMaster bm
	INNER JOIN tblBodyPostureMapping bma ON bm.BodyPostureID=bma.BodyPostureID
	WHERE bm.GarmentType=@GarmentType
	ORDER BY bma.BodyPostureName

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