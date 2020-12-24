SELECT        pm.GarmentID, pm.GarmentName, SM.StyleID, SM.StyleName
FROM            dbo.GarmentStyleMapping AS gsm INNER JOIN
                         dbo.tblStyleMaster AS SM ON gsm.StyleID = SM.StyleID INNER JOIN
                         dbo.tblProductMaster AS pm ON gsm.GarmentID = pm.GarmentID