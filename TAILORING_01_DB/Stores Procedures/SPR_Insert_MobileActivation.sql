-- =============================================
-- Author:		<AAMIR>
-- Create date: <11th MAR 2021>
-- Update date: <>
-- Description:	<Description,,>
-- =============================================
--EXEC SPR_Insert_MobileActivation 'serialno','activation code'
CREATE PROCEDURE SPR_Insert_MobileActivation
@SerialNumber	nvarchar(max)=''
,@ActivationCode	nvarchar(max)=''

AS
BEGIN

	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@SerialNumber,',',@ActivationCode)

	BEGIN TRANSACTION


	INSERT INTO tblMobileActivation
	(SerialNumber,ActivationCode)
	VALUES(@SerialNumber,@ActivationCode)

	COMMIT

	END TRY

	BEGIN CATCH
	
	ROLLBACK

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
GO