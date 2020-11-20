CREATE TRIGGER [dbo].[TRtblTempBodyPostureMaster] ON [dbo].[tblTempBodyPostureMaster] 
AFTER INSERT
AS

BEGIN

    SET NOCOUNT ON;
	DECLARE @BodyPostureType VARCHAR(MAX)=0
	DECLARE @GarmentType VARCHAR(MAX)=0

	DECLARE @BodyPostureID INT=0

	DECLARE curMeasurementMapping CURSOR FOR
		SELECT BodyPostureID,BodyPostureType,GarmentType
		FROM INSERTED

	OPEN curMeasurementMapping
    FETCH NEXT FROM curMeasurementMapping INTO @BodyPostureID,@BodyPostureType,@GarmentType
    WHILE @@FETCH_STATUS <> -1
    BEGIN
		
		IF NOT EXISTS(SELECT 1 FROM tblBodyPostureMaster WITH(NOLOCK) WHERE BodyPostureType=@BodyPostureType AND GarmentType=@GarmentType)
		BEGIN
			IF ISNULL(@BodyPostureType,'')!='' OR ISNULL(@GarmentType,'')!=''
			BEGIN
			INSERT INTO tblBodyPostureMaster
			(
				BodyPostureType
				,GarmentType
			)
			SELECT
			 @BodyPostureType
			 ,@GarmentType

				UPDATE tblTempBodyPostureMaster SET MappingStatus='Done' WHERE BodyPostureID=@BodyPostureID
			END

			ELSE 
			BEGIN
				UPDATE tblTempBodyPostureMaster SET MappingStatus='Invalid Data' WHERE BodyPostureID=@BodyPostureID
			END

		END
		ELSE
		BEGIN
			UPDATE tblTempBodyPostureMaster SET MappingStatus='Already Mapped' WHERE BodyPostureID=@BodyPostureID
		END
    FETCH NEXT FROM curMeasurementMapping INTO @BodyPostureID,@BodyPostureType,@GarmentType
    END
    CLOSE curMeasurementMapping
    DEALLOCATE curMeasurementMapping

END