﻿-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <10th OCT 2020>
-- Update date: <>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Search_Customer]
CREATE PROCEDURE [dbo].[SPR_Search_Customer]
@Name NVARCHAR(MAX)='0'
,@MobileNo VARCHAR(MAX)='0'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@Name,',',@MobileNo)

	SELECT CustomerID,[Name],[Address],MobileNo,EmailID AS [EmailID]
	,(CASE ActiveStatus WHEN 1 THEN 'Active' WHEN 0 THEN 'InActive' END) ActiveStatus 
	FROM dbo.CustomerMaster WITH(NOLOCK)
	WHERE Name LIKE IIF(@Name='0',Name,'%'+@Name+'%')
	AND MobileNo LIKE IIF(@MobileNo='0',MobileNo,'%'+@MobileNo+'%')

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
GO