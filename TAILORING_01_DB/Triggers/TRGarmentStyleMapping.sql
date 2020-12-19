CREATE TRIGGER [dbo].[TRGarmentStyleMapping] ON [dbo].[tblTempGarmentStyleMapping] 
AFTER INSERT
AS

BEGIN

    SET NOCOUNT ON;
	DECLARE @pStyleName VARCHAR(MAX)=0
	DECLARE @pGarmentName VARCHAR(MAX)=0

	DECLARE @pStyleID INT=0
	DECLARE @pGarmentID INT=0
	DECLARE @IsMandatory BIT=0
	DECLARE @GarmentStyleID INT=0

	DECLARE curGarStyleMapping CURSOR FOR
		SELECT GarmentStyleID,StyleID,GarmentID,IsMandatory
		FROM INSERTED

	OPEN curGarStyleMapping
    FETCH NEXT FROM curGarStyleMapping INTO @GarmentStyleID,@pStyleName, @pGarmentName,@IsMandatory
    WHILE @@FETCH_STATUS <> -1
    BEGIN
      
	  SET @pStyleID=(SELECT StyleID FROM [dbo].[tblStyleMaster] WITH(NOLOCK) WHERE StyleName=@pStyleName)
	  SET @pGarmentID=(SELECT GarmentID FROM tblProductMaster WITH(NOLOCK) WHERE GarmentName=@pGarmentName)
		
		IF NOT EXISTS(SELECT 1 FROM GarmentStyleMapping WITH(NOLOCK) WHERE StyleID=@pStyleID AND GarmentID=@pGarmentID)
		BEGIN
			IF ISNULL(@pStyleID,0)>0 AND ISNULL(@pGarmentID,0)>0
			BEGIN
			INSERT INTO GarmentStyleMapping
			(
				StyleID
				,GarmentID
				,IsMandatory
				,TypeID
				,CreatedBy
			)
			SELECT
			 @pStyleID
			,@pGarmentID
			,@IsMandatory
			,0
			,0

				UPDATE tblTempGarmentStyleMapping SET MappingStatus='Done' WHERE GarmentStyleID=@GarmentStyleID
			END

			ELSE 
			BEGIN
				UPDATE tblTempGarmentStyleMapping SET MappingStatus='Invalid Data' WHERE GarmentStyleID=@GarmentStyleID
			END

		END
		ELSE
		BEGIN
			UPDATE tblTempGarmentStyleMapping SET MappingStatus='Already Mapped' WHERE GarmentStyleID=@GarmentStyleID
		END
    FETCH NEXT FROM curGarStyleMapping INTO @GarmentStyleID,@pStyleName, @pGarmentName,@IsMandatory
    END
    CLOSE curGarStyleMapping
    DEALLOCATE curGarStyleMapping

END