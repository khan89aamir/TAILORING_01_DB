CREATE TRIGGER [dbo].[TRtblTempBodyPostureMapping] ON [dbo].[tblTempBodyPostureMapping] 
AFTER INSERT
AS

BEGIN

    SET NOCOUNT ON;
	DECLARE @pBodyPostureType VARCHAR(MAX)=0
	DECLARE @pBodyPostureName VARCHAR(MAX)=0
	DECLARE @pBodyPostureImage VARCHAR(MAX)=0

	DECLARE @pBodyPostureID INT=0
	DECLARE @BodyPostureMappingID INT=0

	DECLARE curBodyPostureImgMapping CURSOR FOR
		SELECT BodyPostureMappingID,BodyPostureID,BodyPostureName,BodyPostureImage
		FROM INSERTED

	OPEN curBodyPostureImgMapping
    FETCH NEXT FROM curBodyPostureImgMapping INTO @BodyPostureMappingID,@pBodyPostureType, @pBodyPostureName,@pBodyPostureImage
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      
	  SET @pBodyPostureID=(SELECT BodyPostureID FROM [dbo].[tblBodyPostureMaster] WITH(NOLOCK) WHERE BodyPostureType=@pBodyPostureType)
		
		IF NOT EXISTS(SELECT 1 FROM tblBodyPostureMapping WITH(NOLOCK) WHERE BodyPostureID=@pBodyPostureID AND BodyPostureName=@pBodyPostureName AND BodyPostureImage=@pBodyPostureImage)
		BEGIN
			IF ISNULL(@pBodyPostureID,0)>0
			BEGIN
			INSERT INTO tblBodyPostureMapping
			(
				BodyPostureID
				,BodyPostureName
				,BodyPostureImage
			)
			SELECT
			 @pBodyPostureID
			,@pBodyPostureName
			,@pBodyPostureImage

				UPDATE tblTempBodyPostureMapping SET MappingStatus='Done' WHERE BodyPostureMappingID=@BodyPostureMappingID
			END

			ELSE 
			BEGIN
				UPDATE tblTempBodyPostureMapping SET MappingStatus='Invalid Data' WHERE BodyPostureMappingID=@BodyPostureMappingID
			END

		END
		ELSE
		BEGIN
			UPDATE tblTempBodyPostureMapping SET MappingStatus='Already Mapped' WHERE BodyPostureMappingID=@BodyPostureMappingID
		END
    FETCH NEXT FROM curBodyPostureImgMapping INTO  @BodyPostureMappingID,@pBodyPostureType, @pBodyPostureName,@pBodyPostureImage
    END
    CLOSE curBodyPostureImgMapping
    DEALLOCATE curBodyPostureImgMapping

END