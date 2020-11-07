-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <11th OCT 2020>
-- Update date: <13th OCT 2020>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Update_Employee] 0,0,0,0,0,0
CREATE PROCEDURE [dbo].[SPR_Update_Employee]
@EMPID INT=0
,@EmployeeCode NVarChar(MAX)=0
,@Name NVarChar(MAX)=0
,@MobileNo VarChar(MAX)=0
,@Gender BIT=0
,@DOB DATETIME=0
,@EmployeeType INT=0
,@Address NVARCHAR(MAX)=0
,@Photo VARBINARY(MAX)=0
,@ActiveStatus BIT=0
,@UpdatedBy INT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@EmployeeCode,',',@Name,',',@MobileNo,',',@Gender,',',@DOB,',',@EmployeeType,',',@Address,',',@Photo,',',@ActiveStatus,',',@UpdatedBy)
	BEGIN TRANSACTION

	UPDATE EmployeeDetails SET
	EmployeeCode=@EmployeeCode,Name=@Name,MobileNo=@MobileNo,Gender=@Gender,DOB=IIF(@DOB='',null,@DOB)
	,EmployeeType=@EmployeeType,[Address]=@Address
	,Photo=IIF(@Photo=0,null,@Photo),ActiveStatus=@ActiveStatus,UpdatedBy=@UpdatedBy,UpdatedOn=GETDATE()
	WHERE EmpID=@EMPID

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