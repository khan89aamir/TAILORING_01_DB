CREATE TRIGGER [dbo].[TRtblTempStyleImageMasterMapping] ON [dbo].[tblTempStyleImageMaster] 
AFTER INSERT
AS

BEGIN

    SET NOCOUNT ON;
	DECLARE @pStyleName VARCHAR(MAX)=0
	DECLARE @pGarmentName VARCHAR(MAX)=0
	DECLARE @pImageName VARCHAR(MAX)=0

	DECLARE @pStyleID INT=0
	DECLARE @pGarmentID INT=0
	DECLARE @StyleImageID INT=0

	DECLARE curGarStyleImgMapping CURSOR FOR
		SELECT StyleImageID,StyleID,GarmentID,ImageName
		FROM INSERTED

	OPEN curGarStyleImgMapping
    FETCH NEXT FROM curGarStyleImgMapping INTO @StyleImageID,@pStyleName, @pGarmentName,@pImageName
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      
	  SET @pStyleID=(SELECT StyleID FROM [dbo].[tblStyleMaster] WITH(NOLOCK) WHERE StyleName=@pStyleName)
	  SET @pGarmentID=(SELECT GarmentID FROM tblProductMaster WITH(NOLOCK) WHERE GarmentName=@pGarmentName)
		
		IF NOT EXISTS(SELECT 1 FROM tblStyleImageMaster WITH(NOLOCK) WHERE StyleID=@pStyleID AND GarmentID=@pGarmentID AND ImageName=@pImageName)
		BEGIN
			IF ISNULL(@pStyleID,0)>0 AND ISNULL(@pGarmentID,0)>0
			BEGIN
			INSERT INTO tblStyleImageMaster
			(
				StyleID
				,GarmentID
				,ImageName
				,CreatedBy
			)
			SELECT
			 @pStyleID
			,@pGarmentID
			,@pImageName
			,0

				UPDATE tblTempStyleImageMaster SET MappingStatus='Done' WHERE StyleImageID=@StyleImageID
			END

			ELSE 
			BEGIN
				UPDATE tblTempStyleImageMaster SET MappingStatus='Invalid Data' WHERE StyleImageID=@StyleImageID
			END

		END
		ELSE
		BEGIN
			UPDATE tblTempStyleImageMaster SET MappingStatus='Already Mapped' WHERE StyleImageID=@StyleImageID
		END
    FETCH NEXT FROM curGarStyleImgMapping INTO @StyleImageID,@pStyleName, @pGarmentName,@pImageName
    END
    CLOSE curGarStyleImgMapping
    DEALLOCATE curGarStyleImgMapping

END