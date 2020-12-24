CREATE VIEW [dbo].[vw_GarmentStyleImgMapping]
AS
SELECT        pm.GarmentID, pm.GarmentName, SM.StyleID, SM.StyleName, sim.ImageName, sim.StyleImageID
FROM            dbo.GarmentStyleMapping AS gsm INNER JOIN
                         dbo.tblStyleMaster AS SM ON gsm.StyleID = SM.StyleID INNER JOIN
                         dbo.tblProductMaster AS pm ON gsm.GarmentID = pm.GarmentID INNER JOIN
                         dbo.tblStyleImageMaster AS sim ON pm.GarmentID = sim.GarmentID AND SM.StyleID = sim.StyleID

GO