-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <22nd OCT 2020>
-- Update date: <14th JAN 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Get_GarmentStyle] 1
CREATE PROCEDURE [dbo].[SPR_Get_GarmentStyle]
@GarmentID INT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=@GarmentID

	SELECT sp.StyleID,sm.StyleName
	FROM [GarmentStyleMapping] sp
	INNER JOIN [tblStyleMaster] sm ON sp.StyleID=sm.StyleID
	INNER JOIN [tblProductMaster] pm ON sp.GarmentID=pm.GarmentID
	WHERE sp.GarmentID=@GarmentID
	ORDER BY sm.StyleID

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