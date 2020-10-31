-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <22nd OCT 2020>
-- Update date: <1st November 2020>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Get_GarmentStyle_Images] 1,11
CREATE PROCEDURE [dbo].[SPR_Get_GarmentStyle_Images]
@GarmentID INT=0
,@StyleID INT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@GarmentID,',',@StyleID)

	SELECT sim.StyleImageID,sp.StyleID,sim.ImageName [ImagePath]
	,REPLACE(REPLACE(sim.ImageName,'C:\Tailoring Images\',''),'.jpg','') [ImageName]
	FROM [GarmentStyleMapping] sp
	INNER JOIN [tblStyleMaster] sm ON sp.StyleID=sm.StyleID
	INNER JOIN [tblProductMaster] pm ON sp.GarmentID=pm.GarmentID
	INNER JOIN tblStyleImageMaster sim ON sp.StyleID=sim.StyleID AND sp.GarmentID=sim.GarmentID
	WHERE sp.GarmentID=@GarmentID AND sp.StyleID=@StyleID

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