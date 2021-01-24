CREATE FUNCTION [dbo].[fc_FileExists](@path VARCHAR(8000))
RETURNS BIT
AS
BEGIN
     DECLARE @result INT
     EXEC master.dbo.xp_fileexist @path, @result OUTPUT
     RETURN CAST(@result AS BIT)
END;

GO