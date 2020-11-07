-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <12th OCT 2020>
-- Update date: <13th OCT 2020>
-- Description:	<Description,,>
-- =============================================
--EXEC SPR_Validate_Employee 0,0,0
CREATE PROCEDURE [dbo].[SPR_Validate_Employee]
@EMPID INT=0
,@EmployeeCode NVARCHAR(MAX)=0
,@MobileNo VARCHAR(MAX)=0
,@ActiveStatus BIT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @Activecount INT=0
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@EMPID,',',@EmployeeCode,',',@MobileNo,',',@ActiveStatus)
	
	SET @Activecount=(SELECT ConfigValue FROM [dbo].[tblTailoringConfig] WITH(NOLOCK) WHERE ConfigName='ActivationCount')

	IF @EMPID = 0
	BEGIN

		IF EXISTS(SELECT 1 FROM dbo.EmployeeDetails WITH(NOLOCK) 
		WHERE EmployeeCode=@EmployeeCode)
		BEGIN

			SELECT 0 AS Flag,CONCAT('EmployeeCode [',@EmployeeCode,'] is already exist.') AS MSg
	
		END

		ELSE IF EXISTS(SELECT 1 FROM dbo.EmployeeDetails WITH(NOLOCK) 
		WHERE MobileNo=@MobileNo)
		BEGIN

			SELECT -1 AS Flag,CONCAT('MobileNo [',@MobileNo,'] is already exist.') AS MSg
	
		END
	
		ELSE IF (SELECT COUNT(1) FROM dbo.EmployeeDetails WITH(NOLOCK) 
		WHERE ActiveStatus=1) >= @Activecount
		BEGIN

			SELECT -2 AS Flag,CONCAT('Employee Activation Reach maximum limit ',@Activecount) AS MSg
	
		END
	 
		ELSE
		BEGIN

			SELECT 1 AS Flag

		END

	END

	ELSE
	BEGIN

	IF EXISTS(SELECT 1 FROM dbo.EmployeeDetails WITH(NOLOCK) 
		WHERE EmployeeCode=@EmployeeCode AND EmpID<> @EMPID)
		BEGIN

			SELECT 0 AS Flag,CONCAT('EmployeeCode [',@EmployeeCode,'] is already exist.') AS MSg
	
		END

		ELSE IF EXISTS(SELECT 1 FROM dbo.EmployeeDetails WITH(NOLOCK) 
		WHERE MobileNo=@MobileNo AND EMPID<>@EMPID)
		BEGIN

			SELECT -1 AS Flag,CONCAT('MobileNo [',@MobileNo,'] is already exist.') AS MSg
	
		END
	
		ELSE IF (SELECT COUNT(1) FROM dbo.EmployeeDetails WITH(NOLOCK) 
		WHERE ActiveStatus=1) >= @Activecount
		BEGIN

			SELECT -2 AS Flag,CONCAT('Employee Activation Reach maximum limit ',@Activecount) AS MSg
	
		END
	 
		ELSE
		BEGIN

			SELECT 1 AS Flag

		END

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