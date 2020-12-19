CREATE TRIGGER [dbo].[TRtblTempStyleMaster] ON [dbo].[tblTempStyleMaster] 
AFTER INSERT
AS

BEGIN

    SET NOCOUNT ON;
	DECLARE @pStyleName VARCHAR(MAX)=0

	DECLARE @StyleMappingID INT=0

	DECLARE curMeasurementMapping CURSOR FOR
		SELECT StyleID,StyleName
		FROM INSERTED

	OPEN curMeasurementMapping
    FETCH NEXT FROM curMeasurementMapping INTO @StyleMappingID,@pStyleName
    WHILE @@FETCH_STATUS <> -1
    BEGIN
		
		IF NOT EXISTS(SELECT 1 FROM tblStyleMaster WITH(NOLOCK) WHERE StyleName=@pStyleName)
		BEGIN
			IF ISNULL(@pStyleName,'')!=''
			BEGIN
			INSERT INTO tblStyleMaster
			(
				StyleName
				,CreatedBy
			)
			SELECT
			 @pStyleName
			,0

				UPDATE tblTempStyleMaster SET MappingStatus='Done' WHERE StyleID=@StyleMappingID
			END

			ELSE 
			BEGIN
				UPDATE tblTempStyleMaster SET MappingStatus='Invalid Data' WHERE StyleID=@StyleMappingID
			END

		END
		ELSE
		BEGIN
			UPDATE tblTempStyleMaster SET MappingStatus='Already Mapped' WHERE StyleID=@StyleMappingID
		END
    FETCH NEXT FROM curMeasurementMapping INTO @StyleMappingID,@pStyleName
    END
    CLOSE curMeasurementMapping
    DEALLOCATE curMeasurementMapping

END