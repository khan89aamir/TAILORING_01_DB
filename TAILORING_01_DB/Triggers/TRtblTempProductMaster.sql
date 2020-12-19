CREATE TRIGGER [dbo].[TRtblTempProductMaster] ON [dbo].[tblTempProductMaster] 
AFTER INSERT
AS

BEGIN

    SET NOCOUNT ON;
	DECLARE @GarmentCode NVARCHAR(MAX)=0
	DECLARE @GarmentName NVARCHAR(MAX)=0
	DECLARE @Photo VARCHAR(MAX)=0
	DECLARE @GarmentType VARCHAR(MAX)=0
	DECLARE @GarmentID INT=0

	DECLARE curMeasurementMapping CURSOR FOR
		SELECT GarmentID,GarmentCode,GarmentName,GarmentType,Photo
		FROM INSERTED

	OPEN curMeasurementMapping
    FETCH NEXT FROM curMeasurementMapping INTO @GarmentID,@GarmentCode,@GarmentName,@GarmentType,@Photo
    WHILE @@FETCH_STATUS <> -1
    BEGIN
		
		IF NOT EXISTS(SELECT 1 FROM tblProductMaster WITH(NOLOCK) WHERE GarmentName=@GarmentName)
		BEGIN
			IF ISNULL(@GarmentName,'')!=''
			BEGIN
			INSERT INTO tblProductMaster
			(
				GarmentCode
				,GarmentName
				,GarmentType
				,Photo
				,CreatedBy
			)
			SELECT
			 @GarmentCode
			 ,@GarmentName
			 ,@GarmentType
			 ,@Photo
			 ,0

				UPDATE tblTempProductMaster SET MappingStatus='Done' WHERE GarmentID=@GarmentID
			END

			ELSE 
			BEGIN
				UPDATE tblTempProductMaster SET MappingStatus='Invalid Data' WHERE GarmentID=@GarmentID
			END

		END
		ELSE
		BEGIN
			UPDATE tblTempProductMaster SET MappingStatus='Already Mapped' WHERE GarmentID=@GarmentID
		END
    FETCH NEXT FROM curMeasurementMapping INTO @GarmentID,@GarmentCode,@GarmentName,@GarmentType,@Photo
    END
    CLOSE curMeasurementMapping
    DEALLOCATE curMeasurementMapping

END