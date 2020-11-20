CREATE TRIGGER [dbo].[TRGarmentMeasureMapping] ON [dbo].[tblTempGarmentMeasureMapping] 
AFTER INSERT
AS

BEGIN

    SET NOCOUNT ON;
	DECLARE @pMeasurementName VARCHAR(MAX)=0
	DECLARE @pGarmentName VARCHAR(MAX)=0

	DECLARE @pMeasurementID INT=0
	DECLARE @pGarmentID INT=0
	DECLARE @IsMandatory BIT=0

	DECLARE curGarMeasureMapping CURSOR FOR
		SELECT MeasurementID,GarmentID,IsMandatory
		FROM INSERTED

	OPEN curGarMeasureMapping
    FETCH NEXT FROM curGarMeasureMapping INTO @pMeasurementName, @pGarmentName,@IsMandatory
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      
	  SET @pMeasurementID=(SELECT MeasurementID FROM tblMeasurementMaster WHERE MeasurementName=@pMeasurementName)
	  SET @pGarmentID=(SELECT GarmentID FROM tblProductMaster WHERE GarmentName=@pGarmentName)
		
		IF NOT EXISTS(SELECT 1 FROM GarmentMeasurementMapping WITH(NOLOCK) WHERE MeasurementID=@pMeasurementID AND GarmentID=@pGarmentID)
		BEGIN
			INSERT INTO GarmentMeasurementMapping
			(
				MeasurementID
				,GarmentID
				,IsMandatory
				,TypeID
				,CreatedBy
			)
			SELECT
			 @pMeasurementID
			,@pGarmentID
			,@IsMandatory
			,0
			,0
		END
    FETCH NEXT FROM curGarMeasureMapping INTO @pMeasurementName, @pGarmentName,@IsMandatory
    END
    CLOSE curGarMeasureMapping
    DEALLOCATE curGarMeasureMapping

END