﻿-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <02nd JAN 2021>
-- Update date: <>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Insert_GSTData] 0,0,0,0,0,0
CREATE PROCEDURE [dbo].[SPR_Insert_GSTData]
@CGST DECIMAL(18,2)=0
,@SGST DECIMAL(18,2)=0
,@IGST DECIMAL(18,2)=0
,@CreatedBy INT=0
,@GSTID INT=0 OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@CGST,',',@SGST,',',@IGST,',',@CreatedBy)
	BEGIN TRANSACTION

	INSERT tblGSTMaster
	(
		CGST,SGST,IGST,CreatedBy
	)
	VALUES
	(
		@CGST,@SGST,@IGST,@CreatedBy
	)
	SET @GSTID=SCOPE_IDENTITY()

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