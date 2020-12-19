CREATE TRIGGER [dbo].[TRtblTempMeasurementMaster] ON [dbo].[tblTempMeasurementMaster] 
AFTER INSERT
AS

BEGIN

    SET NOCOUNT ON;
	DECLARE @pMeasurementName VARCHAR(MAX)=0

	DECLARE @MeasureMappingID INT=0

	DECLARE curMeasurementMapping CURSOR FOR
		SELECT MeasurementID,MeasurementName
		FROM INSERTED

	OPEN curMeasurementMapping
    FETCH NEXT FROM curMeasurementMapping INTO @MeasureMappingID,@pMeasurementName
    WHILE @@FETCH_STATUS <> -1
    BEGIN
		
		IF NOT EXISTS(SELECT 1 FROM tblMeasurementMaster WITH(NOLOCK) WHERE MeasurementName=@pMeasurementName)
		BEGIN
			IF ISNULL(@pMeasurementName,'')!=''
			BEGIN
			INSERT INTO tblMeasurementMaster
			(
				MeasurementName
				,CreatedBy
			)
			SELECT
			 @pMeasurementName
			,0

				UPDATE tblTempMeasurementMaster SET MappingStatus='Done' WHERE MeasurementID=@MeasureMappingID
			END

			ELSE 
			BEGIN
				UPDATE tblTempMeasurementMaster SET MappingStatus='Invalid Data' WHERE MeasurementID=@MeasureMappingID
			END

		END
		ELSE
		BEGIN
			UPDATE tblTempMeasurementMaster SET MappingStatus='Already Mapped' WHERE MeasurementID=@MeasureMappingID
		END
    FETCH NEXT FROM curMeasurementMapping INTO @MeasureMappingID,@pMeasurementName
    END
    CLOSE curMeasurementMapping
    DEALLOCATE curMeasurementMapping

END