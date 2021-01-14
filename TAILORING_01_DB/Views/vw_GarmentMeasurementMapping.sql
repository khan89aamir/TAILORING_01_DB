﻿CREATE VIEW [dbo].[vw_GarmentMeasurementMapping]
AS 
SELECT pm.GarmentID, pm.GarmentName, MM.MeasurementID, MM.MeasurementName
FROM dbo.GarmentMeasurementMapping AS gmm INNER JOIN
dbo.tblMeasurementMaster AS MM ON gmm.MeasurementID = MM.MeasurementID INNER JOIN
dbo.tblProductMaster AS pm ON gmm.GarmentID = pm.GarmentID

GO