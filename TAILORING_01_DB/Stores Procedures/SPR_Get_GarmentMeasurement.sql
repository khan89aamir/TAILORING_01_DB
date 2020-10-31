-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <21st OCT 2020>
-- Update date: <22nd OCT 2020>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Get_GarmentMeasurement] 1
CREATE PROCEDURE [dbo].[SPR_Get_GarmentMeasurement]
@GarmentID INT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=@GarmentID

	SELECT --mp.GarmentMeasurementID,mp.TypeID,mp.GarmentID,
	mp.MeasurementID,mm.MeasurementName
	--,pm.GarmentName
	,mp.IsMandatory
	FROM [GarmentMeasurementMapping] mp
	INNER JOIN [tblMeasurementMaster] mm ON mp.MeasurementID=mm.MeasurementID
	INNER JOIN [tblProductMaster] pm ON mp.GarmentID=pm.GarmentID
	WHERE mp.GarmentID=@GarmentID

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