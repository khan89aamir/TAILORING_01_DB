-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <24th DEC 2020>
-- Update date: <08th JAN 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Get_Product_Rate] 2
CREATE PROCEDURE [dbo].[SPR_Get_Product_Rate]
@OrderType INT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	DECLARE @IMGPATH VARCHAR(MAX)=''

	SET @PARAMERES=@OrderType

	SET @IMGPATH=(SELECT [ConfigValue]
	FROM [dbo].[tblTailoringConfig] WITH(NOLOCK) WHERE [ConfigName]='GenericImagePath')

	SELECT pm.GarmentID,pm.GarmentCode,pm.GarmentName
	,CONCAT(pm.GarmentCode,' ',pm.GarmentName) [GarmentCodeName]
	,pm.GarmentType,prm.Rate
	,(CASE prm.OrderType WHEN 1 THEN 'Urgent' WHEN 0 THEN 'Normal' END) OrderType
	,IIF(pm.Photo IS NULL,pm.Photo,CONCAT(@IMGPATH,pm.Photo)) Photo
	,Convert(INT,prm.LastChange) LastChange
	FROM tblProductMaster pm
	INNER JOIN tblProductRateMaster prm ON pm.GarmentID=prm.GarmentID
	WHERE prm.OrderType=IIF(@OrderType=2,prm.OrderType,@OrderType)
	ORDER BY pm.GarmentID

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