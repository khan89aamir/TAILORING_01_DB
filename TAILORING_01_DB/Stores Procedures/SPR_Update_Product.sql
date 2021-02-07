-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <12th OCT 2020>
-- Update date: <07th FEB 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Update_Product] 0,0,0,0,0,0
CREATE PROCEDURE [dbo].[SPR_Update_Product]
@GarmentID INT=0
,@GarmentName NVarChar(MAX)=0
,@GarmentType VARCHAR(MAX)=0
,@UpdatedBy INT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@GarmentID,',',@GarmentName,',',@GarmentType,',',@UpdatedBy)
	BEGIN TRANSACTION

	UPDATE tblProductMaster SET
	GarmentName=@GarmentName
	,GarmentType=@GarmentType
	,UpdatedBy=@UpdatedBy,UpdatedOn=GETDATE()
	WHERE GarmentID=@GarmentID

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