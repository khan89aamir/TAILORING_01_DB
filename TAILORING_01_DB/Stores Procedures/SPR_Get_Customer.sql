﻿-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <25th DEC 2020>
-- Update date: <12th OCT 2020>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Get_Customer]
CREATE PROCEDURE [dbo].[SPR_Get_Customer]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''

	SELECT CustomerID,Name,[Address],MobileNo,EmailID,CONVERT(INT,LastChange) LastChange
	FROM dbo.CustomerMaster WITH(NOLOCK)

	END TRY

	BEGIN CATCH
	
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