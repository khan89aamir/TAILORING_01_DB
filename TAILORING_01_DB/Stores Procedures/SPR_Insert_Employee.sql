-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <11th OCT 2020>
-- Update date: <13th OCT 2020>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Insert_Employee] 0,0,0,0,0,0
CREATE PROCEDURE [dbo].[SPR_Insert_Employee]
@EmployeeCode NVarChar(MAX)=0
,@Name NVarChar(MAX)=0
,@MobileNo VarChar(MAX)=0
,@Gender BIT=0
,@DOB DATETIME=0
,@EmployeeType INT=0
,@Address NVARCHAR(MAX)=0
,@Photo VARBINARY(MAX)=0
,@ActiveStatus BIT=0
,@CreatedBy INT=0
,@EMPID INT=0 OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@EmployeeCode,',',@Name,',',@MobileNo,',',@Gender,',',@DOB,',',@EmployeeType,',',@Address,',',@Photo,',',@ActiveStatus,',',@CreatedBy)
	BEGIN TRANSACTION

	INSERT EmployeeDetails
	(
		EmployeeCode,Name,MobileNo,Gender,DOB,EmployeeType,[Address],Photo,ActiveStatus,CreatedBy
	)
	VALUES
	(
		@EmployeeCode,@Name,@MobileNo,@Gender,IIF(@DOB='',null,@DOB),@EmployeeType,@Address,IIF(@Photo=0,null,@Photo),@ActiveStatus,@CreatedBy
	)

	COMMIT

	SELECT @EMPID=SCOPE_IDENTITY();

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