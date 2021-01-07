CREATE VIEW [dbo].[vw_GarmentStyle_rdlc]
	AS
SELECT        sm.StyleID, s1.StyleImageID, sm.ImageName, s1.SalesOrderID, sm.GarmentID, s1.QTY
FROM            dbo.tblCustomerStyle AS s1 INNER JOIN
                         dbo.tblStyleImageMaster AS sm ON s1.StyleImageID = sm.StyleImageID

