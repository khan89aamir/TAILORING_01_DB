CREATE VIEW [dbo].[vw_Garment_Measurment_rdlc]
	AS 
SELECT        m1.MeasurementName, c1.MeasurementValue,c1.SalesOrderID,c1.GarmentID
FROM            dbo.tblCustomerMeasurement AS c1 INNER JOIN
                         dbo.tblMeasurementMaster AS m1 ON c1.MeasurementID = m1.MeasurementID
WHERE        (c1.MeasurementValue <> 0)