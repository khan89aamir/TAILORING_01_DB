﻿/*
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

TRUNCATE TABLE [dbo].[tblSoftwareSetting]
SET IDENTITY_INSERT [dbo].[tblSoftwareSetting] ON 
GO
INSERT [dbo].[tblSoftwareSetting] ([SoftwareSettingID], [ImagePath], [GenericImagePath], [CopyOrderMonth], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) 
VALUES (1, N'C:\Tailoring Images', N'C:\Tailoring Images\Generic', 3, 0, CAST(N'2021-02-22 17:35:13.520' AS DateTime), 0, CAST(N'2021-02-22 17:36:08.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tblSoftwareSetting] OFF
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


SET IDENTITY_INSERT [dbo].[tblBodyPostureMaster] OFF


TRUNCATE TABLE [dbo].[tblOrderStatusMaster]

SET IDENTITY_INSERT [dbo].[tblOrderStatusMaster] ON 

GO
INSERT [dbo].[tblOrderStatusMaster] ([Id], [OrderStatus]) VALUES (1, N'Delivered')
GO
INSERT [dbo].[tblOrderStatusMaster] ([Id], [OrderStatus]) VALUES (2, N'Critical')
GO
INSERT [dbo].[tblOrderStatusMaster] ([Id], [OrderStatus]) VALUES (3, N'In Process')
GO
INSERT [dbo].[tblOrderStatusMaster] ([Id], [OrderStatus]) VALUES (4, N'Received')
GO
SET IDENTITY_INSERT [dbo].[tblOrderStatusMaster] OFF