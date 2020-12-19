CREATE TRIGGER [dbo].[TRtblTempProductRateMaster] ON [dbo].[tblTempProductRateMaster] 
AFTER INSERT
AS

BEGIN

    SET NOCOUNT ON;
	DECLARE @GarmentName NVARCHAR(MAX)=0
	DECLARE @Rate DECIMAL(18,2)=0
	DECLARE @OrderType VARCHAR(MAX)=0
	
	DECLARE @GarmentID INT=0
	DECLARE @GarmentRateID INT=0

	DECLARE curMeasurementMapping CURSOR FOR
		SELECT GarmentRateID,GarmentID,OrderType,Rate
		FROM INSERTED

	OPEN curMeasurementMapping
    FETCH NEXT FROM curMeasurementMapping INTO @GarmentRateID,@GarmentName,@OrderType,@Rate
    WHILE @@FETCH_STATUS <> -1
    BEGIN
		
		SET @GarmentID=(SELECT GarmentID FROM tblProductMaster WITH(NOLOCK) WHERE GarmentName=@GarmentName)
		IF Lower(@OrderType)='urgent'
		BEGIN
			SET @OrderType=1
		END
		
		ELSE
		BEGIN
			SET @OrderType=0
		END

		IF NOT EXISTS(SELECT 1 FROM tblProductRateMaster WITH(NOLOCK) WHERE GarmentID=@GarmentID AND OrderType=@OrderType)
		BEGIN
			IF ISNULL(@GarmentID,0)>0
			BEGIN
			INSERT INTO tblProductRateMaster
			(
				GarmentID
				,Rate
				,OrderType
				,CreatedBy
			)
			SELECT
			 @GarmentID
			 ,@Rate
			 ,@OrderType
			 ,0

				UPDATE tblTempProductRateMaster SET MappingStatus='Done' WHERE GarmentRateID=@GarmentRateID
			END

			ELSE 
			BEGIN
				UPDATE tblTempProductRateMaster SET MappingStatus='Invalid Data' WHERE GarmentRateID=@GarmentRateID
			END

		END
		ELSE
		BEGIN
			UPDATE tblTempProductRateMaster SET MappingStatus='Already Mapped' WHERE GarmentRateID=@GarmentRateID
		END
    FETCH NEXT FROM curMeasurementMapping INTO @GarmentRateID,@GarmentName,@OrderType,@Rate
    END
    CLOSE curMeasurementMapping
    DEALLOCATE curMeasurementMapping

END