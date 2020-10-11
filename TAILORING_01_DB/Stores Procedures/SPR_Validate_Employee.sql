-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <12th OCT 2020>
-- Description:	<Description,,>
-- =============================================
--EXEC SPR_Validate_Employee 0,0,0
CREATE PROCEDURE SPR_Validate_Employee
@EMPID INT=0
,@EmployeeCode NVARCHAR(MAX)=0
,@MobileNo VARCHAR(MAX)=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@EMPID,',',@EmployeeCode,',',@MobileNo)
	
	IF EXISTS(SELECT 1 FROM dbo.EmployeeDetails WITH(NOLOCK) 
	WHERE EmployeeCode=@EmployeeCode AND EMPID<>@EMPID)
	BEGIN

		SELECT 0 AS Flag,CONCAT('EmployeeCode [',@EmployeeCode,'] is already exist.') AS MSg
	
	END

	ELSE IF EXISTS(SELECT 1 FROM dbo.EmployeeDetails WITH(NOLOCK) 
	WHERE MobileNo=@MobileNo AND EMPID<>@EMPID)
	BEGIN

		SELECT 2 AS Flag,CONCAT('MobileNo [',@MobileNo,'] is already exist.') AS MSg
	
	END

	ELSE
	BEGIN

		SELECT 1 AS Flag

	END
	
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