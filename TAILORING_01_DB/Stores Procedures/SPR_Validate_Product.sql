-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <12th OCT 2020>
-- Update date: <07th FEB 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC SPR_Validate_Product 0,0,0
CREATE PROCEDURE [dbo].[SPR_Validate_Product]
@GarmentID INT=0
,@GarmentName NVARCHAR(MAX)=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@GarmentID,',',@GarmentName)
	
	IF EXISTS(SELECT 1 FROM dbo.tblProductMaster WITH(NOLOCK) 
	WHERE GarmentName=@GarmentName AND GarmentID<>IIF(@GarmentID=0,GarmentID,@GarmentID) )
	BEGIN

		SELECT 0 AS Flag,CONCAT('GarmentName [',@GarmentName,'] is already exist.') AS MSg
	
	END

	ELSE
	BEGIN

		SELECT 1 AS Flag

	END
	
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