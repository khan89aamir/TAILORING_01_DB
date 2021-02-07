-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <08th JAN 2021>
-- Update date: <07th FEB 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Insert_Product_Rate] 0,0,0,0,0,0
CREATE PROCEDURE [dbo].[SPR_Insert_Product_Rate]
@GarmentID INT=0
,@GarmentCode NVARCHAR(MAX)=0
,@Rate DECIMAL(18,2)=0
,@OrderType INT=0
,@CreatedBy INT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@GarmentID,',',@GarmentCode,',',@Rate,',',@OrderType,',',@CreatedBy)
	BEGIN TRANSACTION

	INSERT [dbo].[tblProductRateMaster]
	(
		GarmentID,GarmentCode,Rate,OrderType,CreatedBy
	)
	VALUES
	(
		@GarmentID,@GarmentCode,@Rate,@OrderType,@CreatedBy
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