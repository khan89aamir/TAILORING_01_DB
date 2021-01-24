/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
DECLARE @IMGPATH VARCHAR(MAX)=''
SET @IMGPATH=(SELECT [ConfigValue] FROM [dbo].[tblTailoringConfig] WITH(NOLOCK) WHERE [ConfigName]='ImagePath')
 SELECT *,CONCAT(@IMGPATH,ImageName),dbo.fc_FileExists(CONCAT(@IMGPATH,ImageName)) [IsExist] FROM vw_GarmentStyleImgMapping 
 ORDER BY dbo.fc_FileExists(CONCAT(@IMGPATH,ImageName))
*/
TRUNCATE TABLE [dbo].[tblTailoringConfig]

INSERT INTO [dbo].[tblTailoringConfig](ConfigName,ConfigValue)
VALUES('ActivationCount','3')
GO

INSERT INTO [dbo].[tblTailoringConfig](ConfigName,ConfigValue)
VALUES('ImagePath','C:\Tailoring Images\')
GO

INSERT INTO [dbo].[tblTailoringConfig](ConfigName,ConfigValue)
VALUES('GenericImagePath','C:\Tailoring Images\Generic\')
GO


TRUNCATE TABLE [dbo].[tblFitTypeMaster]
SET IDENTITY_INSERT [dbo].[tblFitTypeMaster] ON 

INSERT INTO [dbo].[tblFitTypeMaster](FitTypeID,FitTypeName)
VALUES(1,'Slim Fit')
GO

INSERT INTO [dbo].[tblFitTypeMaster](FitTypeID,FitTypeName)
VALUES(2,'Regular Fit')
GO

INSERT INTO [dbo].[tblFitTypeMaster](FitTypeID,FitTypeName)
VALUES(3,'Comfort Fit')
GO
SET IDENTITY_INSERT [dbo].[tblFitTypeMaster] OFF 

TRUNCATE TABLE [dbo].[tblStichTypeMaster]

SET IDENTITY_INSERT [dbo].[tblStichTypeMaster] ON 
INSERT INTO [dbo].[tblStichTypeMaster](StichTypeID,StichTypeName)
VALUES(1,'Trail')
GO

INSERT INTO [dbo].[tblStichTypeMaster](StichTypeID,StichTypeName)
VALUES(2,'Finish')
GO
SET IDENTITY_INSERT [dbo].[tblStichTypeMaster] OFF 

TRUNCATE TABLE [dbo].[tblBodyPostureMaster]

SET IDENTITY_INSERT [dbo].[tblBodyPostureMaster] ON 
INSERT INTO [dbo].[tblBodyPostureMaster](BodyPostureID,BodyPostureType,GarmentType)
VALUES(1,'Stmouch','Top')
GO

INSERT INTO [dbo].[tblBodyPostureMaster](BodyPostureID,BodyPostureType,GarmentType)
VALUES(2,'Back','Top')
GO

INSERT INTO [dbo].[tblBodyPostureMaster](BodyPostureID,BodyPostureType,GarmentType)
VALUES(3,'Shoulder','Top')
GO

INSERT INTO [dbo].[tblBodyPostureMaster](BodyPostureID,BodyPostureType,GarmentType)
VALUES(4,'Leg Shape','Bottom')
GO

SET IDENTITY_INSERT [dbo].[tblBodyPostureMaster] OFF