-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <11th OCT 2020>
-- Update date: <28th JAN 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Search_Employee]
CREATE PROCEDURE [dbo].[SPR_Search_Employee]
@Name NVARCHAR(MAX)='0'
,@MobileNo VARCHAR(MAX)='0'
,@EmpID INT=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''
	SET @PARAMERES=CONCAT(@Name,',',@MobileNo,',',@EmpID)

	SELECT EmpID,EmployeeCode,Name,MobileNo,(CASE Gender WHEN 1 THEN 'Male' WHEN 0 THEN 'Female' END) Gender
	,DOB,[Address],(CASE EmployeeType WHEN 0 THEN 'Admin' WHEN 1 THEN 'Master' END) EmployeeType
	,Photo,(CASE ActiveStatus WHEN 1 THEN 'Active' WHEN 0 THEN 'InActive' END) ActiveStatus
	,CONVERT(INT,LastChange) LastChange
	FROM dbo.EmployeeDetails WITH(NOLOCK)
	WHERE EmpID=IIF(@EmpID=0,EmpID,@EmpID)
	AND Name LIKE IIF(@Name='0',Name,'%'+@Name+'%')
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