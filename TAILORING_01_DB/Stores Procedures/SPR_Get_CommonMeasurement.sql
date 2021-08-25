 -- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <22th JAN 2021>
-- Update date: <21st AUG 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].SPR_Get_CommonMeasurement 1
CREATE PROCEDURE [dbo].[SPR_Get_CommonMeasurement]
@GarmentID INT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=@GarmentID

	SELECT cmt.GarmentID,cmt.MeasurementID
    FROM tblCommonMeasurement cmt
    INNER JOIN
    (
    select MeasurementID
    FROM [dbo].[tblCommonMeasurement] WITH(NOLOCK)
    GROUP BY [MeasurementID]
    HAVING COUNT(MeasurementID)>1
    )t ON cmt.MeasurementID=t.MeasurementID
	WHERE cmt.GarmentID=@GarmentID
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