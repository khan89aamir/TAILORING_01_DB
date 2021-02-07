-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <07th FEB 2021>
-- Update date: <>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Search_Product_Rate] 0,2
CREATE PROCEDURE [dbo].[SPR_Search_Product_Rate]
@GarmentName NVARCHAR(MAX)='0'
,@OrderType INT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	DECLARE @IMGPATH VARCHAR(MAX)=''

	SET @PARAMERES=CONCAT(@GarmentName,',',@OrderType)

	SET @IMGPATH=(SELECT [ConfigValue]
	FROM [dbo].[tblTailoringConfig] WITH(NOLOCK) WHERE [ConfigName]='GenericImagePath')

	SELECT prm.GarmentRateID,pm.GarmentID,prm.GarmentCode,pm.GarmentName
	,CONCAT(prm.GarmentCode,' ',pm.GarmentName) [GarmentCodeName]
	,pm.GarmentType,ISNULL(prm.Rate,0) Rate
	,(CASE prm.OrderType WHEN 1 THEN 'Urgent' WHEN 0 THEN 'Normal' END) OrderType
	,IIF(pm.Photo IS NULL,pm.Photo,CONCAT(@IMGPATH,pm.Photo)) Photo
	,Convert(INT,prm.LastChange) LastChange
	FROM tblProductMaster pm
	INNER JOIN tblProductRateMaster prm ON pm.GarmentID=prm.GarmentID
	WHERE pm.GarmentName LIKE IIF(@GarmentName='0',pm.GarmentName,'%'+@GarmentName+'%')
	AND prm.OrderType=IIF(@OrderType=2,prm.OrderType,@OrderType)
	--AND prm.OrderType=@OrderType
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