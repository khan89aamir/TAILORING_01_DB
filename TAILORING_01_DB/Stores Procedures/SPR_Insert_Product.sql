-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <12th OCT 2020>
-- Update date: <>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Insert_Product] 0,0,0,0,0,0
CREATE PROCEDURE [dbo].[SPR_Insert_Product]
@GarmentCode NVarChar(MAX)=0
,@GarmentName NVarChar(MAX)=0
,@CreatedBy INT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@GarmentCode,',',@GarmentName,',',@CreatedBy)
	BEGIN TRANSACTION

	INSERT tblProductMaster
	(
		GarmentCode,GarmentName,CreatedBy
	)
	VALUES
	(
		@GarmentCode,@GarmentName,@CreatedBy
	)

	COMMIT

	END TRY

	BEGIN CATCH
	
	ROLLBACK

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