CREATE VIEW [dbo].[vw_GarmentStyleMapping]
AS
SELECT  gsm.GarmentStyleID, pm.GarmentID, pm.GarmentName, SM.StyleID, SM.StyleName, gsm.IsMandatory
FROM dbo.GarmentStyleMapping AS gsm 
INNER JOIN dbo.tblStyleMaster AS SM ON gsm.StyleID = SM.StyleID 
INNER JOIN dbo.tblProductMaster AS pm ON gsm.GarmentID = pm.GarmentID

GO