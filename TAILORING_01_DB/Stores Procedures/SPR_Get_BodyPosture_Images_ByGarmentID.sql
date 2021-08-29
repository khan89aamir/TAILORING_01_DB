-- =============================================
-- Author:		<AAMIR>
-- Create date: <29th AUG 2021>
-- Update date: <>
-- Description:	<Description,,>
-- =============================================
--EXEC SPR_Get_BodyPosture_Images_ByGarmentID 1,1
CREATE PROCEDURE [dbo].[SPR_Get_BodyPosture_Images_ByGarmentID]
@GarmentID INT=0
,@BodyPostureID INT=0

AS
BEGIN

	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	DECLARE @GarmentType VARCHAR(MAX)=''
	DECLARE @ImagePath VARCHAR(MAX)=''

	SET @PARAMERES=CONCAT(@GarmentID,',',@BodyPostureID)

	SET @ImagePath=(SELECT TOP 1 ImagePath FROM tblSoftwareSetting WITH(NOLOCK))
	SET @ImagePath=CONCAT(@ImagePath,'\')

	SET @GarmentType=(SELECT GarmentType
	FROM tblProductMaster WITH(NOLOCK) WHERE GarmentID=@GarmentID)

	--SELECT bm.BodyPostureID,bm.BodyPostureType
	--FROM tblBodyPostureMaster bm WITH(NOLOCK)
	--WHERE bm.GarmentType=@GarmentType

	SELECT bma.BodyPostureMappingID,bm.BodyPostureID,bm.BodyPostureType,bma.BodyPostureName
	,bma.BodyPostureImage AS Photo1
	,IIF(bma.BodyPostureImage IS NULL,bma.BodyPostureImage,CONCAT(@ImagePath,bma.BodyPostureImage)) Photo
	FROM tblBodyPostureMaster bm
	INNER JOIN tblBodyPostureMapping bma ON bm.BodyPostureID=bma.BodyPostureID
	WHERE bm.GarmentType=@GarmentType
	AND bm.BodyPostureID=@BodyPostureID
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