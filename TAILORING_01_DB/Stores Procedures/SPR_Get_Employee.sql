-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <11th OCT 2020>
-- Update date: <13th OCT 2020>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[SPR_Get_Employee]
CREATE PROCEDURE [dbo].[SPR_Get_Employee]
@EmpID INT=0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	DECLARE @PARAMERES VARCHAR(MAX)=''

	SELECT EmpID,EmployeeCode,Name,MobileNo,(CASE Gender WHEN 1 THEN 'Male' WHEN 0 THEN 'Female' END) Gender
	,DOB,[Address],(CASE EmployeeType WHEN 0 THEN 'Admin' WHEN 1 THEN 'Master' END) EmployeeType
	,Photo,(CASE ActiveStatus WHEN 1 THEN 'Active' WHEN 0 THEN 'InActive' END) ActiveStatus
	FROM dbo.EmployeeDetails WITH(NOLOCK)
	WHERE EmpID=IIF(@EmpID=0,EmpID,@EmpID)

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